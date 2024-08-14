//
//  LoopingPlayerProtocol.swift
//
//
//  Created by Igor Shelopaev on 05.08.24.
//

import AVFoundation
import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif
/// A protocol defining the requirements for a looping video player.
///
/// Conforming types are expected to manage a video player that can loop content continuously,
/// handle errors, and notify a delegate of important events.
@available(iOS 14, macOS 11, tvOS 14, *)
@MainActor @preconcurrency
public protocol LoopingPlayerProtocol: AbstractPlayer, LayerMakerProtocol{
    
    #if canImport(UIKit)
        var layer : CALayer { get }
    #elseif canImport(AppKit)
        var layer : CALayer? { get set }
        var wantsLayer : Bool { get set }
    #endif
    
    var playerLayer : AVPlayerLayer { get }

    /// The delegate to be notified about errors encountered by the player.
    var delegate: PlayerErrorDelegate? { get set }

    /// An optional NSKeyValueObservation to monitor errors encountered by the video player.
    /// This observer should be configured to detect and handle errors from the AVQueuePlayer,
    /// ensuring that all playback errors are managed and reported appropriately.
    var errorObserver: NSKeyValueObservation? { get set }

    /// Initializes a video player with a specified media asset and layer gravity.
    /// - Parameters:
    ///   - asset: The `AVURLAsset` representing the media content to be played. This asset encapsulates the properties of the media file.
    ///   - gravity: The `AVLayerVideoGravity` that determines how the video content is displayed within the bounds of the player layer. Common values are `.resizeAspect`, `.resizeAspectFill`, and `.resize` to control the scaling and filling behavior of the video content.
    init(asset: AVURLAsset, gravity: AVLayerVideoGravity)
    
    /// Sets up the necessary observers on the AVPlayerItem and AVQueuePlayer to monitor changes and errors.
    ///
    /// - Parameters:
    ///   - item: The AVPlayerItem to observe for status changes.
    ///   - player: The AVQueuePlayer to observe for errors.
    func setupObservers(for item: AVPlayerItem, player: AVQueuePlayer)

    /// Responds to errors reported by the AVQueuePlayer.
    ///
    /// - Parameter player: The AVQueuePlayer that encountered an error.
    func handlePlayerError(_ player: AVPlayer)
}

internal extension LoopingPlayerProtocol {
    
    /// Updates the player to play a new asset and handles the playback state.
    ///
    /// - Parameters:
    ///   - asset: The AVURLAsset to load into the player.
    func update(asset: AVURLAsset){
        
        guard let player = player else { return }
        
        let wasPlaying = player.rate != 0
        
        if wasPlaying {
            pause()
        }

        // Cleaning
        unloop()
        clearPlayerQueue()
        removeAllFilters()
        
        // Replace the current item
        let newItem = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: newItem)
        loop()
        applyVideoComposition()
        
        player.seek(to: .zero, completionHandler: { [weak self] _ in
            if wasPlaying {
                self?.play()
            }
        })
    }
    
    /// Sets up the player components using the provided asset and video gravity.
    ///
    /// - Parameters:
    ///   - asset: The AVURLAsset to be played.
    ///   - gravity: The AVLayerVideoGravity to be applied to the video layer.
    func setupPlayerComponents(asset: AVURLAsset, gravity: AVLayerVideoGravity) {
        // Create an AVPlayerItem with the provided asset
        let item = AVPlayerItem(asset: asset)
        
        // Initialize an AVQueuePlayer with the player item
        let player = AVQueuePlayer(items: [item])
        self.player = player
        
        // Configure the player with the specified gravity
        configurePlayer(player, gravity: gravity)
        
        // Set up observers to monitor status and errors
        setupObservers(for: item, player: player)
    }
    
    /// Configures the provided AVQueuePlayer with specific properties for video playback.
    ///
    /// - Parameters:
    ///   - player: The AVQueuePlayer to be configured.
    ///   - gravity: The AVLayerVideoGravity determining how the video content should be scaled or fit within the player layer.
    func configurePlayer(_ player: AVQueuePlayer, gravity: AVLayerVideoGravity) {
        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = gravity
        #if canImport(UIKit)
        playerLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(playerLayer)
        layer.addSublayer(compositeLayer)
        #elseif canImport(AppKit)
        playerLayer.backgroundColor = NSColor.clear.cgColor
        let layer = CALayer()
        layer.addSublayer(playerLayer)
        layer.addSublayer(compositeLayer)
        self.layer = layer
        self.wantsLayer = true
        #endif
        compositeLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        loop()
        if !filters.isEmpty{ // have an idea for the feature
            applyVideoComposition()
        }
        player.play()
    }
    
    /// Sets up observers on the player item and the player to track their status and error states.
    ///
    /// - Parameters:
    ///   - item: The player item to observe.
    ///   - player: The player to observe.
    func setupObservers(for item: AVPlayerItem, player: AVQueuePlayer) {
        errorObserver = player.observe(\.error, options: [.new]) { [weak self] player, _ in
            self?.handlePlayerError(player)
        }
    }
    
    /// Removes observers for handling errors.
    ///
    /// This method ensures that the error observer is properly invalidated and the reference is cleared.
    /// It is important to call this method to prevent memory leaks and remove any unwanted side effects
    /// from obsolete observers.
    func removeObservers() {
        errorObserver?.invalidate()
        errorObserver = nil
    }

    /// Responds to errors reported by the AVPlayer.
    ///
    /// If an error is present, this method notifies the delegate of the encountered error,
    /// encapsulated within a `remoteVideoError`.
    /// - Parameter player: The AVPlayer that encountered an error to be evaluated.
    func handlePlayerError(_ player: AVPlayer) {
        guard let error = player.error else { return }
        delegate?.didReceiveError(.remoteVideoError(error))
    }
    
    /// Processes an asynchronous video composition request by applying a series of CIFilters.
    /// This function ensures each frame processed conforms to specified filter effects.
    ///
    /// - Parameters:
    ///   - request: An AVAsynchronousCIImageFilteringRequest object representing the current video frame to be processed.
    ///   - filters: An array of CIFilters to be applied sequentially to the video frame.
    ///
    /// The function starts by clamping the source image to ensure coordinates remain within the image bounds,
    /// applies each filter in the provided array, and completes by returning the modified image to the composition request.
    static func handleVideoComposition(request: AVAsynchronousCIImageFilteringRequest, filters: [CIFilter]) {
        // Start with the source image, ensuring it's clamped to avoid any coordinate issues
        var currentImage = request.sourceImage.clampedToExtent()
        
        // Apply each filter in the array to the image
        for filter in filters {
            filter.setValue(currentImage, forKey: kCIInputImageKey)
            if let outputImage = filter.outputImage {
                currentImage = outputImage.clampedToExtent()
            }
        }
        // Finish the composition request by outputting the final image
        request.finish(with: currentImage, context: nil)
    }
    
    /// Applies the current set of filters to the video using an AVVideoComposition.
    /// This method combines the existing filters and brightness/contrast adjustments, creates a new video composition,
    /// and assigns it to the current AVPlayerItem. The video is paused during this process to ensure smooth application.
    /// This method is not supported on Vision OS.
    func applyVideoComposition() {
        guard let player = player else { return }
        let allFilters = combineFilters(filters, brightness, contrast)
        
        #if !os(visionOS)
        // Optionally, check if the player is currently playing
        let wasPlaying = player.rate != 0
        
        // Pause the player if it was playing
        if wasPlaying {
            player.pause()
        }
               
        player.items().forEach{ item in
            
            let videoComposition = AVVideoComposition(asset: item.asset, applyingCIFiltersWithHandler: { request in
                Self.handleVideoComposition(request: request, filters: allFilters)
            })

            item.videoComposition = videoComposition
        }
        
        if wasPlaying{
            player.play()
        }
        
        #endif
    }
    
    /// Cleans up the player and its associated resources.
    ///
    /// This function performs several cleanup tasks to ensure that the player is properly
    /// decommissioned. It pauses playback, removes any registered observers, stops any
    /// looping, removes all applied filters, and finally nils out the player to release it
    /// for garbage collection. This method is marked with `@preconcurrency` to indicate that
    /// it is safe to call in both concurrent and non-concurrent environments, preserving
    /// compatibility with older code that does not use Swift's new concurrency model.
    @preconcurrency
    func cleanUp() {
        
        pause()
        
        removeObservers()
        
        unloop()
        
        clearPlayerQueue()
        
        removeAllFilters()
        
        player = nil
        delegate = nil

        #if DEBUG
        print("Cleaned up Player!")
        #endif
    }
    
    /// Clears all items from the player's queue.
    func clearPlayerQueue() {
        guard let items = player?.items() else { return }
        for item in items {
            player?.remove(item)
        }
    }
    
    /// Sets the playback command for the video player.
    /// - Parameter value: The `PlaybackCommand` to set. This can be one of the following:
    ///   - `play`: Command to play the video.
    ///   - `pause`: Command to pause the video.
    ///   - `seek(to:)`: Command to seek to a specific time in the video.
    ///   - `begin`: Command to position the video at the beginning.
    ///   - `end`: Command to position the video at the end.
    ///   - `mute`: Command to mute the video.
    ///   - `unmute`: Command to unmute the video.
    ///   - `volume`: Command to adjust the volume of the video playback.
    ///   - `subtitles`: Command to set subtitles to a specified language or turn them off.
    ///   - `playbackSpeed`: Command to adjust the playback speed of the video.
    ///   - `loop`: Command to enable looping of the video playback.
    ///   - `unloop`: Command to disable looping of the video playback.
    ///   - `brightness`: Command to adjust the brightness of the video playback.
    ///   - `contrast`: Command to adjust the contrast of the video playback.
    ///   - `filter`: Command to apply a specific Core Image filter to the video.
    ///   - `removeAllFilters`: Command to remove all applied filters from the video playback.
    ///   - `audioTrack`: Command to select a specific audio track based on language code.
    ///   - `vector`: Sets a vector graphic operation on the video player.
    ///   - `removeAllVectors`: Clears all vector graphics from the video player.
    func setCommand(_ value: PlaybackCommand) {
        switch value {
        case .play:
            play()
        case .pause:
            pause()
        case .seek(to: let time):
            seek(to: time)
        case .begin:
            seekToStart()
        case .end:
            seekToEnd()
        case .mute:
            mute()
        case .unmute:
            unmute()
        case .volume(let volume):
            setVolume(volume)
        case .subtitles(let language):
            setSubtitles(to: language)
        case .playbackSpeed(let speed):
            setPlaybackSpeed(speed)
        case .loop:
            loop()
        case .unloop:
            unloop()
        case .brightness(let brightness):
            adjustBrightness(to: brightness)
        case .contrast(let contrast):
            adjustContrast(to: contrast)
        case .filter(let value, let clear):
            applyFilter(value, clear)
        case .removeAllFilters:
            removeAllFilters()
        case .audioTrack(let languageCode):
            selectAudioTrack(languageCode: languageCode)
        case .addVector(let builder, let clear):
            addVectorLayer(builder: builder, clear: clear)
        case .removeAllVectors:
            removeAllVectors()
        }
    }
}
