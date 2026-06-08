## ⭐ Star it, please — so I know it’s worth improving further
iOS 14+, macOS 11+, tvOS 14+


## Added support for Metal shaders
*Take a look on "Demo project"*
Support for applying **Metal shaders** directly to **video frames**.  
Real-time effects on the timeline, no extra copies or heavy post-processing. 

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftuiux%2Fswiftui-loop-videoplayer%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/swiftuiux/swiftui-loop-videoplayer)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fswiftuiux%2Fswiftui-loop-videoPlayer%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/swiftuiux/swiftui-loop-videoPlayer)


It is a pure package without any third-party libraries. My main focus was on performance. Especially if you need to add a video in the background as a design element, in such cases, you’d want a lightweight component without a lot of unnecessary features. **I hope it serves you well**.

### 🟩 Demo project showing video player usage and features: [follow the link](https://github.com/swiftuiux/swiftui-video-player-example)



## Why if we have Apple’s VideoPlayer ?!

Apple’s VideoPlayer provides a quick way to add video playback in SwiftUI, but it does not allow you to hide or customize the default video controls. This makes it less suitable for custom playback scenarios.

One alternative is to use AVPlayerViewController, but that often brings in more functionality than needed, especially when the goal is simply to control or replace the default UI.

This solution is designed as a lightweight, modular framework: integrate only what you need instead of pulling in a large codebase your app never uses. You can integrate only the features you need while keeping the core component simple. It gives you full control over playback and makes it easy to build custom UI for background videos, tooltips, video hints, onboarding flows, and other custom use cases.

It also supports more advanced features, including subtitles, seamless looping, real-time filters, vector graphics overlays, frame data access, and custom video processing. This makes it possible to apply **ML or AI algorithms** directly to the video stream for analysis, enhancement, or transformation.

*This package uses a declarative approach to declare parameters for the video component based on building blocks. This implementation might give some insights into how SwiftUI works under the hood. You can also pass parameters in the common way. If you profile the package, do it on a real device.*

 ```swift            
   ExtVideoPlayer{
        VideoSettings{
            SourceName("swipe") 
        }
    } 
``` 

or

 ```swift 
    ExtVideoPlayer(fileName: 'swipe')  
```  

## Philosophy of Player Dynamics

The player's functionality is designed around a dual &#8646; interaction model:

- **Commands and Settings**: Through these, you instruct the player on what to do and how to do it. Settings define the environment and initial state, while commands offer real-time control. As for now, you can conveniently pass command by command; perhaps later I’ll add support for batch commands
  
- **Event Feedback**: Through event handling, the player communicates back to the application, informing it of internal changes that may need attention. Due to the nature of media players, especially in environments with dynamic content or user interactions, the flow of events can become flooded. To manage this effectively and prevent the application from being overwhelmed by the volume of incoming events, the **system collects these events every second and returns them as a batch**. Pass `Events()` in the `settings` to enable event mechanism.

## [Documentation(API)](https://swiftpackageindex.com/swiftuiux/swiftui-loop-videoplayer/main/documentation/swiftui_loop_videoplayer)

![The concept](https://github.com/swiftuiux/swiftui-video-player-example/blob/main/swiftui-loop-videoplayer-example/img/swiftui_video_player.gif) 

## Implemented Specs
*The [sample app](https://github.com/swiftuiux/swiftui-video-player-example) demonstrates the majority of the specs implemented in the component*

| **Feature Category**      | **Feature Name**                            | **Description**                                                                                          |
|----------------------------|---------------------------------------------|----------------------------------------------------------------------------------------------------------|
| **General**               | SwiftUI Declarative Syntax                  | Easily integrate using declarative syntax.                                                              |
|                           | Platform Compatibility                      | Supports iOS 14+, macOS 11+, tvOS 14+.                                                                  |
|                           | Swift Compatibility                      | Alined with Swift 5 and ready for Swift 6                                                                |
|                           | Loop Playback                               | Automatically restart videos when they end.                                                             |
|                           | Local and Remote Video URLs                 | Supports playback from local files or remote URLs.                                                      |
|                           | Adaptive HLS Streaming                      | Handles HLS streaming with dynamic quality adjustment.                                                  |
|                           | Error Handling                              | Customizable error messages and visual displays.                                                        |
|                           | Subtitle Support                            | Add external `.vtt` files or use embedded subtitle tracks.                                               |
|                           | Custom Overlays                             | Add vector graphics and custom overlays over the video.                                                 |
|                           | Picture In Picture (PiP)                            | Picture-in-Picture (PiP) is supported on iOS and iPadOS                                                |
| **Playback Commands**      | Idle Command                                | Initialize without specific playback actions.                                                           |
|                           | Play/Pause                                  | Control playback state.                                                                                 |
|                           | Seek Command                                | Move to specific video timestamps.                                                                      |
|                           | Mute/Unmute                                 | Toggle audio playback.                                                                                  |
|                           | Volume Control                              | Adjust audio levels.                                                                                    |
|                           | Playback Speed                              | Dynamically modify playback speed.                                                                      |
|                           | Loop/Unloop                                 | Toggle looping behavior.                                                                                |
|                           | Apply Filters                               | Add Core Image filters to the video stream.                                                            |
|                           | Remove Filters                              | Clear all applied filters.                                                                              |
|                           | Add Vector Graphics                         | Overlay custom vector graphics onto the video.                                                          |
| **Settings**               | SourceName                                 | Define video source (local or remote).                                                                  |
|                           | File Extension                              | Default extension for video files (e.g., `.mp4`).                                                       |
|                           | Gravity                                     | Set content resizing behavior (e.g., `.resizeAspect`).                                                  |
|                           | Time Publishing                             | Control playback time reporting intervals.                                                              |
|                           | AutoPlay                                    | Toggle automatic playback on load.                                                                      |
|                           | Mute by Default                             | Initialize playback without sound.                                                                      |
|                           | Subtitle Integration                        | Configure subtitles from embedded tracks or external files.                                             |
| **Visual Features**        | Rounded Corners                            | Apply rounded corners using SwiftUI's `.mask` modifier.                                                 |
|                           | Overlay Graphics                            | Add vector graphics over video for custom effects.                                                      |
|                           | Brightness Adjustment                       | Control brightness levels dynamically.                                                                  |
|                           | Contrast Adjustment                         | Modify video contrast in real time.                                                                     |
| **Playback Features**      | Adaptive HLS Streaming                     | Dynamic quality adjustment based on network speed.                                                      |
|                           | Seamless Item Transitions                   | Smooth transitions between video items.                                                                 |
|                           | Multichannel Audio                          | Play Dolby Atmos, 5.1 surround, and spatial audio tracks.                                               |
|                           | Subtitles and Captions                      | Support for multiple subtitle and caption formats.                                                      |
| **Event Handling**         | Batch Event Processing                     | Collects and processes events in batches to avoid flooding.                                             |
|                           | Playback State Events                       | `playing`, `paused`, `seek`, `duration(CMTime)`, etc.                                                   |
|                           | Current Item State                          | Detect when the current item changes or is removed.                                                     |
|                           | Volume Change Events                        | Listen for changes in volume levels.                                                                    |
| **Testing & Development**  | Unit Testing                               | Includes unit tests for core functionality.                                                             |
|                           | UI Testing                                  | Integration of UI tests in the example app.                                                             |
|                           | Example Scripts                             | Automated testing scripts for easier test execution.                                                    |
| **Media Support**          | File Types                                 | `.mp4`, `.mov`, `.m4v`, `.3gp`, `.mkv` (limited support).                                                |
|                           | Codecs                                      | H.264, H.265 (HEVC), MPEG-4, AAC, MP3.                                                                  |
|                           | Streaming Protocols                         | HLS (`.m3u8`) support for adaptive streaming.                                                           |

### CornerRadius
You can reach out the effect simply via mask modifier
 ```swift
    ExtVideoPlayer(
        settings : $settings,
        command: $playbackCommand,
        VideoSettings{
           SourceName("swipe") 
       }
    )
    .mask{
        RoundedRectangle(cornerRadius: 25)
    }
 ```
 
 ![CornerRadius effect video player swift](https://github.com/swiftuiux/swiftui-video-player-example/blob/main/swiftui-loop-videoplayer-example/img/cornerRadius.png) 

### By the way
[Perhaps that might be enough for your needs](https://github.com/swiftuiux/swiftui-loop-videoPlayer/issues/7#issuecomment-2341268743)




## Testing

The package includes unit tests that cover key functionality. While not exhaustive, these tests help ensure the core components work as expected. UI tests are in progress and are being developed [in the example application](https://github.com/swiftuiux/swiftui-video-player-example). The run_tests.sh is an example script that automates testing by encapsulating test commands into a single executable file, simplifying the execution process. You can configure the script to run specific testing environment relevant to your projects.

## Disclaimer on Video Sources like YouTube
Please note that using videos from URLs requires ensuring that you have the right to use and stream these videos. Videos hosted on platforms like YouTube cannot be used directly due to restrictions in their terms of service.

## API

| Property/Method                                             | Type                          | Description                                                                                          |
|-------------------------------------------------------------|-------------------------------|------------------------------------------------------------------------------------------------------|
| `settings`                                                  | `Binding<VideoSettings>`       | A binding to the video player settings, which configure various aspects of the player's behavior.    |
| `command`                                                   | `Binding<PlaybackCommand>`     | A binding to control playback actions, such as play, pause, or seek.                                 |
| `init(fileName:ext:gravity:timePublishing:` <br> `command:)` | Constructor                    | Initializes the player with specific video parameters, such as file name, extension, gravity, time publishing and a playback command binding. |
| `init(settings: () -> VideoSettings, command:)`             | Constructor                    | Initializes the player in a declarative way with a settings block and a playback command binding.     |
| `init(settings: Binding<VideoSettings>, command:)`          | Constructor                    | Initializes the player with bindings to the video settings and a playback command.                   |


## Settings

| Name          | Description                                                                                         | Default |
|---------------|-----------------------------------------------------------------------------------------------------|---------|
| **SourceName** | **Direct URL String** If the name represents a valid URL ( HTTP etc). <br> **Local File URL** If the name is a valid local file path (file:// scheme). <br> **Bundle Resource** It tries to locate the file in the main bundle using Bundle.main.url(forResource:withExtension:)                                                             | -       |
| **Ext**        | File extension for the video, used when loading from local resources. This is optional when a URL is provided and the URL ends with the video file extension. | "mp4"  |
| **Gravity** | How the video content should be resized to fit the player's bounds. | .resizeAspect |
| **Loop** | Whether the video should automatically restart when it reaches the end. If not explicitly passed, the video will not loop. | false |
| **Mute** | Indicates if the video should play without sound. | false |
| **NotAutoPlay** | Indicates if the video should not play after initialization. Notice that if you use `command` as a control flow for the player the start command should be `.idle` | false |
| **TimePublishing** | Specifies the interval at which the player publishes the current playback time. | Not Enabled |
| **Subtitles**  | The URL or local filename of the WebVTT (.vtt) subtitles file to be merged with the video. With a AVMutableComposition approach that is used currently in the package, you cannot directly change the position or size of subtitles. AVFoundation’s built-in handling of “text” tracks simply renders them in a default style, without allowing additional layout options. Take a look on the implementation in the example app *Video8.swift*  | Not Enabled       |
| **EnableVector** | Use this struct to activate settings that allow the addition of vector-based overlays via commands. If it is not passed via settings, any commands to `addVector` or `removeAllVectors` will have no effect. | Not Enabled |
|**PictureInPicture**| Enable Picture-in-Picture (PiP) support. If not passed than any command like `startPiP` or `stopPiP` have no effect. Take a look the example app *Video11.swift*. It does not work on simulator. You can observe the feature only on real devices.| Not Enabled |
| **Events([.durationAny, .itemStatusChangedAny])** | If `Events()` is not passed in the `settings: VideoSettings`, the event mechanism is disabled. You can specify exactly which events you want to receive (e.g., .itemStatusChangedAny) or simply pass `Events()` to receive all available events. This setting was added to improve performance because events are emitted via @State changes, which trigger view updates. If you don’t need to observe any events, disabling them can significantly boost performance. Take a look on the implementation in the example app *Video8.swift* | Not Enabled |

### Additional Notes on Settings

- **Time Publishing:**  If the parameter is passed during initialization, the player will publish the time according to the input settings. You can pass just `TimePublishing` without any value to use the default interval of 1 second, or you can pass a specific `CMTime` value to set a custom interval. | 1 second (CMTime with 1 second and preferred timescale of 600) If no `TimePublishing` is provided, the player will not emit time events, which can improve performance when timing information is not needed.

- **SourceName:** If a valid URL (http or https) is provided, the video will be streamed from the URL. If not a URL, the system will check if a video with the given name exists in the local bundle. The local name provided can either include an extension or be without one. The system first checks if the local name contains an extension. If the local name includes an extension, it extracts this extension and uses it as the default. If the local name does not contain an extension, the system assigns a default extension of .mp4 The default file extension can be set up via Ext param. 

- **Loop:** Whether the video should automatically restart when it reaches the end. If not explicitly passed, the video will not loop.


## Commands

### Handling Commands
 ```swift
    @State public var playbackCommand: PlaybackCommand = .idle
 ```
`@State` updates are asynchronous and batched in SwiftUI. When you assign:
 ```swift
    playbackCommand = .play
    playbackCommand = .pause
  ```
SwiftUI only registers the last assignment (`.pause`) in the same run loop cycle, ignoring `.play`.
To ensure .play is applied before .pause, you can use `Task` to schedule the second update on the next run loop iteration:

**.play → .pause**
 ```swift
    playbackCommand = .play
    
    Task {
        playbackCommand = .pause
    }
```
**.play → .pause → .play**
    
```swift  
    playbackCommand = .play

    Task { 
        playbackCommand = .pause
        Task { playbackCommand = .play } // This runs AFTER `.pause`
    }
```
    
### Handling Sequential Similar Commands

When using the video player controls in your SwiftUI application, it's important to understand how command processing works. Specifically, issuing two identical commands consecutively will result in the second command being ignored. This is due to the underlying implementation that prevents redundant command execution to optimize performance and user experience in terms of UI updates.

### Common Scenario

For example, if you attempt to pause the video player twice in a row, the second pause command will have no effect because the player is already in a paused state. Similarly, sending two consecutive play commands will not re-trigger playback if the video is already playing.

### Handling Similar Commands

In cases where you need to re-issue a command that might appear redundant but is necessary under specific conditions, you must insert an `idle` command between the two similar commands. The `idle` command resets the command state of the player, allowing subsequent commands to be processed as new actions.

**.play → .idle → .play**
    
```swift  
    playbackCommand = .play

    Task {
        playbackCommand = .idle
        Task { playbackCommand = .play } // This runs AFTER `.idle`
    }
```   

### Playback Commands

| Command                     | Description                                                                                                                                          |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| `idle`                      | Start without any actions. Any command passed during initialization will be executed. If you'd like to start without any actions based on settings values just setup command to `.idle`                                                                                                                       |
| `play`                      | Command to play the video.                                                                                                                            |
| `pause`                     | Command to pause the video.                                                                                                                           |
| `seek(to: Double, play: Bool)` | Command to seek to a specific time in the video. The time parameter specifies the target position in seconds. If time is negative, playback will jump to the start of the video. If time exceeds the video’s duration, playback will move to the end of the video. For valid values within the video’s duration, playback will move precisely to the specified time. The play parameter determines whether playback should resume automatically after seeking, with a default value of true. |
| `begin`                     | Command to position the video at the beginning.                                                                                                       |
| `end`                       | Command to position the video at the end.                                                                                                             |
| `mute`                      | Command to mute the video. By default, the player is muted.                                                                                           |
| `unmute`                    | Command to unmute the video.                                                                                                                          |
| `volume(Float)`             | Command to adjust the volume of the video playback. The `volume` parameter is a `Float` value between 0.0 (mute) and 1.0 (full volume). If a value outside this range is passed, it will be clamped to the nearest valid value (0.0 or 1.0). |
| `playbackSpeed(Float)`      | Command to adjust the playback speed of the video. The `speed` parameter is a `Float` value representing the playback speed (e.g., 1.0 for normal speed, 0.5 for half speed, 2.0 for double speed). If a negative value is passed, it will be clamped to 0.0. |
| `loop`                      | Command to enable looping of the video playback. By default, looping is enabled, so this command will have no effect if looping is already active.     |
| `unloop`                    | Command to disable looping of the video playback. This command will only take effect if the video is currently being looped.                                                                |
| `startPiP`    | Command to initiate **Picture-in-Picture (PiP)** mode for video playback. If the PiP feature is already active, this command will have no additional effect. Don't forget to add PictureInPicture() in settings to enable the PiP feature.     |
| `stopPiP`     | Command to terminate **Picture-in-Picture (PiP)** mode, returning the video playback to its inline view. If PiP is not active, this command will have no effect. Don't forget to add PictureInPicture() in settings to enable the PiP feature.  |

### Visual Adjustment Commands

| Command                     | Description                                                                                                                                          |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| `brightness(Float)`         | Command to adjust the brightness of the video playback. The `brightness` parameter is a `Float` value typically ranging from -1.0 (darkest) to 1.0 (brightest). Values outside this range will be clamped to the nearest valid value. |
| `contrast(Float)`           | Command to adjust the contrast of the video playback. The `contrast` parameter is a `Float` value typically ranging from 0.0 (no contrast) to 4.0 (high contrast). Values outside this range will be clamped to the nearest valid value. |
| `filter(CIFilter, clear: Bool)` | Applies a specific Core Image filter to the video. If `clear` is true, any existing filters on the stack are removed before applying the new filter; otherwise, the new filter is added to the existing stack. |
| `removeAllFilters`          | Command to remove all applied filters from the video playback.                                                                                        |

### Vector Graphics Commands

| Command                                      | Description                                                                                                                                          |
|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| `addVector(ShapeLayerBuilderProtocol, clear: Bool)` | Command to add a vector graphic layer over the video stream. The `builder` parameter is an instance conforming to `ShapeLayerBuilderProtocol`. The `clear` parameter specifies whether to clear existing vector layers before adding the new one.                                                                                                           |
| `removeAllVectors`                           | Command to remove all vector graphic layers from the video stream.                                                                                    |
### Additional Notes on Vector Graphics Commands
- To use these commands, don’t forget to enable the Vector layer in settings via the EnableVector() setting.
- The boundsChanged event(`boundsChanged(CGRect)`) is triggered when the main layer’s bounds are updated. This approach is particularly useful when overlays or custom vector layers need to adapt dynamically to changes in video player dimensions or other layout adjustments. To handle the frequent boundsChanged events effectively and improve performance, you can use a **throttle** function to limit how often the updates occur.


### Audio & Language Commands

| Command                     | Description                                                                                                                                          |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| `audioTrack(String)`        | Command to select a specific audio track based on language code. The `languageCode` parameter specifies the desired audio track's language (e.g., "en" for English). |
| `subtitles(String?)` | This command sets subtitles to a specified language or turns them off. Provide a language code (for example, `"en"` for English) to display that language's subtitles, or pass `nil` to disable subtitles altogether. **Note**: This only applies when the video file has embedded subtitles tracks. |

### Additional Notes on the subtitles Command
This functionality is designed for use cases where the video file already contains multiple subtitle tracks (i.e., legible media tracks) embedded in its metadata. In other words, the container format (such as MP4, MOV, or QuickTime) holds one or more subtitle or closed-caption tracks that can be selected at runtime. By calling this function and providing a language code (e.g., “en”, “fr”, “de”), you instruct the component to look for the corresponding subtitle track in the asset’s media selection group. If it finds a match, it will activate that subtitle track; otherwise, no subtitles will appear. Passing nil disables subtitles altogether. This approach is convenient when you want to switch between multiple embedded subtitle languages or turn them off without relying on external subtitle files (like SRT or WebVTT).

Another option to add subtitles is by using **Settings** (take a look above), where you can provide subtitles as a separate source file (e.g., SRT or WebVTT). In this case, subtitles are dynamically loaded and managed alongside the video without requiring them to be embedded in the video file itself. 
Both of these methods — using embedded subtitle tracks or adding subtitles via Settings as external files — do not merge and save the resulting video with subtitles locally. Instead, the subtitles are rendered dynamically during playback.

**Configuring HLS Playlist with English Subtitles**

Here’s an example of an HLS playlist configured with English subtitles. The subtitles are defined as a separate track using WebVTT or a similar format, referenced within the master playlist. This setup allows seamless subtitle rendering during video playback, synchronized with the video stream.

```plaintext
#EXTM3U
#EXT-X-MEDIA:TYPE=SUBTITLES,
    GROUP-ID="subs",
    NAME="English Subtitles",
    LANGUAGE="en",
    AUTOSELECT=YES,
    DEFAULT=YES,
    URI="subtitles_en.m3u8"

#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=3000000,
    RESOLUTION=1280x720,
    SUBTITLES="subs"
video_main.m3u8
```

## Player Events

 *If `Events()` is not passed in the `settings: VideoSettings`, the event mechanism is disabled. You can specify exactly which events you want to receive (e.g., .itemStatusChangedAny) or simply pass .all to receive all available events. This setting was added to improve performance because events are emitted via @State changes, which trigger view updates. If you don’t need to observe any events, disabling them can significantly boost performance.*

| Event                              | Description                                                                                                                                       |
|------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| `seek(Bool, currentTime: Double)`  | Represents an end seek action within the player. The first parameter (`Bool`) indicates whether the seek was successful, and the second parameter (`currentTime`) provides the time (in seconds) to which the player is seeking. |
| `paused`                           | Indicates that the player's playback is currently paused. This state occurs when the player has been manually paused by the user or programmatically through a method like `pause()`. The player is not playing any content while in this state. |
| `waitingToPlayAtSpecifiedRate`     | Indicates that the player is currently waiting to play at the specified rate. This state generally occurs when the player is buffering or waiting for sufficient data to continue playback. It can also occur if the playback rate is temporarily reduced to zero due to external factors, such as network conditions or system resource limitations. |
| `playing`                          | Indicates that the player is actively playing content. This state occurs when the player is currently playing video or audio content at the specified playback rate. This is the active state where media is being rendered to the user. |
| `currentItemChanged`    | Triggered when the player's `currentItem` is updated to a new `AVPlayerItem`. This event indicates a change in the media item currently being played. |
| `currentItemRemoved`    | Occurs when the player's `currentItem` is set to `nil`, indicating that the current media item has been removed from the player.                      |
| `error(VPErrors)`                  | Represents an occurrence of an error within the player. The event provides a `VPErrors` enum value indicating the specific type of error encountered. |
| `volumeChanged`         | Happens when the player's volume level is adjusted. This event provides the new volume level, which ranges from 0.0 (muted) to 1.0 (maximum volume).  |
| `boundsChanged(CGRect)` | Triggered when the bounds of the main layer change, allowing the developer to recalculate and update all vector layers within the CompositeLayer. |
| `startedPiP`                        | Event triggered when Picture-in-Picture (PiP) mode starts. |
| `stoppedPiP`                        | Event triggered when Picture-in-Picture (PiP) mode stops. |
| `itemStatusChanged(AVPlayerItem.Status)` | Indicates that the AVPlayerItem's status has changed. Possible statuses: `.unknown`, `.readyToPlay`, `.failed`. |
| `duration(CMTime)`                  | Provides the duration of the AVPlayerItem when it is ready to play. The duration is given in `CMTime`. |

## Player event filter
`PlayerEventFilter` - this enum provides a structured way to filter `PlayerEvent` cases. I decided to introduce an additional structure that corresponds to `PlayerEvent`. All cases with parameters are replicated as *eventName***Any** to match any variation of that event, regardless of its associated values. If you need specific events that match certain event parameters, let me know, and I will add them.

```swift
    ExtVideoPlayer{
            VideoSettings{
                SourceName("swipe")
                Events([.durationAny, .itemStatusChangedAny]) // *Events([PlayerEventFilter])*
            }
        } 
        .onPlayerEventChange { events in
            // Here come only events [.durationAny, .itemStatusChangedAny]: any duration and any item status change events.
        } 
``` 

### Event filter table

| **Filter**                          | **Description** |
|------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| `seekAny`                         | Matches any `.seek(...)` case, regardless of whether the seek was successful (`Bool`) or the target seek time (`currentTime: Double`). |
| `paused`                          | Matches exactly the `.paused` event, which indicates that playback has been paused by the user or programmatically. |
| `waitingToPlayAtSpecifiedRate`     | Matches exactly the `.waitingToPlayAtSpecifiedRate` event, which occurs when the player is buffering or waiting for sufficient data. |
| `playing`                          | Matches exactly the `.playing` event, indicating that the player is actively playing media. |
| `currentItemChangedAny`            | Matches any `.currentItemChanged(...)` case, triggered when the player's `currentItem` is updated to a new media item. |
| `currentItemRemoved`               | Matches exactly the `.currentItemRemoved` event, occurring when the player's `currentItem` is set to `nil`. |
| `errorAny`                         | Matches any `.error(...)` case, representing an error within the player, with a `VPErrors` enum indicating the specific issue. |
| `volumeChangedAny`                 | Matches any `.volumeChanged(...)` case, triggered when the player's volume level is adjusted. |
| `boundsChangedAny`                 | Matches any `.boundsChanged(...)` case, triggered when the bounds of the main layer change. |
| `startedPiP`                       | Matches exactly the `.startedPiP` event, triggered when Picture-in-Picture (PiP) mode starts. |
| `stoppedPiP`                       | Matches exactly the `.stoppedPiP` event, triggered when Picture-in-Picture (PiP) mode stops. |
| `itemStatusChangedAny`             | Matches any `.itemStatusChanged(...)` case, indicating that the AVPlayerItem's status has changed (e.g., `.unknown`, `.readyToPlay`, `.failed`). |
| `durationAny`                      | Matches any `.duration(...)` case, which provides the duration of the media item when ready to play. |


### Additional Notes on Errors
When the URL is syntactically valid but the resource does not actually exist (e.g., a 404 response or an unreachable server), AVPlayerItem.status can remain .unknown indefinitely. It may never transition to .failed, and the .AVPlayerItemFailedToPlayToEndTime notification won’t fire if playback never starts.

**Workarounds and Best Practices**
*Pre-Check the URL With HEAD*

If you want to ensure that a URL is valid before passing it to the component (AVPlayerItem), use for example a simple HEAD request via URLSession to check for a valid 2xx response.

```swift
func checkURLExists(_ url: URL) async throws -> Bool {
    var request = URLRequest(url: url)
    request.httpMethod = "HEAD"

    let (_, response) = try await URLSession.shared.data(for: request)
    if let httpResponse = response as? HTTPURLResponse {
        return (200...299).contains(httpResponse.statusCode)
    }
    return false
}
```

### Additional Notes on Adding and Removing Vector Graphics

When you use the `addVector` command, you can dynamically add a new vector graphic layer (such as a logo or animated vector) over the video stream. This is particularly useful for enhancing the user experience with overlays, such as branding elements, animated graphics.

**Adding a Vector Layer**:
   - The `addVector` command takes a `ShapeLayerBuilderProtocol` instance. This protocol defines the necessary method to build a `CAShapeLayer` based on the given geometry (frame, bounds).
   - The `clear` parameter determines whether existing vector layers should be removed before adding the new one. If set to `true`, all existing vector layers are cleared, and only the new layer will be displayed.
   - The vector layer will be laid out directly over the video stream, allowing it to appear as part of the video playback experience.

**Important Lifecycle Consideration**:
Integrating vector graphics into SwiftUI views, particularly during lifecycle events such as onAppear, requires careful consideration of underlying system behaviors. When vectors are added as the view appears, developers might encounter issues where the builder receives frame and bounds values of zero. This discrepancy stems from the inherent mismatch between the lifecycle of SwiftUI views and the lifecycle of UIView or NSView, depending on the platform. SwiftUI defers much of its view layout and rendering to a later stage in the view lifecycle. To mitigate these issues, a small delay can be introduced during onAppear. I'll try to add this command in the initial config later to cover the case when you need a vector layer at the very early stage of the video streaming.

### Additional Notes on Brightness and Contrast

- **Brightness and Contrast**: These settings function also filters but are managed separately from the filter stack. Adjustments to brightness and contrast are applied additionally and independently of the image filters.
- **Persistent Settings**: Changes to brightness and contrast do not reset when the filter stack is cleared. They remain at their last set values and must be adjusted or reset separately by the developer as needed.
- **Independent Management**: Developers should manage brightness and contrast adjustments through their dedicated methods or properties to ensure these settings are accurately reflected in the video output.


## How to use the package
### 1. Create LoopPlayerView

```swift
    ExtVideoPlayer(fileName: 'swipe')    
```

or in a declarative way

 ```swift
    ExtVideoPlayer{
            VideoSettings{
                SourceName("swipe")
                Subtitles("subtitles_eng")
                Ext("mp8") // Set default extension here If not provided then mp4 is default
                Gravity(.resizeAspectFill)
                TimePublishing()
                Events([.durationAny, .itemStatusChangedAny])
            }
        } 
        .onPlayerTimeChange { newTime in
            // Current video playback time
        }  
        .onPlayerEventChange { events in
            // Player events
        }
```           

```swift
ExtVideoPlayer{
    VideoSettings{
        SourceName('https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8')
    }
}
```

The only required setting is now **SourceName**.


### Supported Video Types and Formats
The AVFoundation framework used in the package supports a wide range of video formats and codecs, including both file-based media and streaming protocols. Below is a list of supported video types, codecs, and streaming protocols organized into a grid according to Apple’s documentation. Sorry, didn’t check all codecs and files.

| Supported File Types     | Supported Codecs | Supported Streaming Protocols      |
|--------------------------|------------------|-------------------------------------|
| **3GP**                  | **H.264**        | **HTTP Live Streaming (HLS)**       |
| `.3gp`, `.3g2`           | **H.265 (HEVC)** | `.m3u8`                             |
| **MKV** (Limited support)| **MPEG-4 Part 2**|                                     |
| `.mkv`                   | **AAC** (audio)  |                                     |
| **MP4**                  | **MP3** (audio)  |                                     |
| `.mp4`                   |                  |                                     |
| **MOV**                  |                  |                                     |
| `.mov`                   |                  |                                     |
| **M4V**                  |                  |                                     |
| `.m4v`                   |                  |                                     |

## Remote Video URLs
The package now supports using remote video URLs, allowing you to stream videos directly from web resources. This is an extension to the existing functionality that primarily focused on local video files. Here's how to specify a remote URL within the settings:

```swift
ExtVideoPlayer{
    VideoSettings{
        SourceName('https://example.com/video')
        Gravity(.resizeAspectFill)  // Video content fit
    }
}
```

### Video Source Compatibility

| Video Source | Possible to Use | Comments |
| --- | --- | --- |
| YouTube | No | Violates YouTube's policy as it doesn't allow direct video streaming outside its platform. |
| Direct MP4 URLs | Yes | Directly accessible MP4 URLs can be used if they are hosted on servers that permit CORS. |
| HLS Streams | Yes | HLS streams are supported and can be used for live streaming purposes. |


## Practical ideas for the package
You can introduce video hints about some functionality into the app, for example how to add positions to favorites. Put loop video hint into background or open as popup.

![The concept](https://github.com/swiftuiux/swiftui-video-player-example/blob/main/swiftui-loop-videoplayer-example/img/swiftui_video_hint.gif)

![The concept](https://github.com/swiftuiux/swiftui-video-player-example/blob/main/swiftui-loop-videoplayer-example/img/tip_video_swiftui.gif)

## HLS with Adaptive Quality

### How Adaptive Quality Switching Works

1. **Multiple Bitrates**
   - The video is encoded in multiple quality levels (e.g., 240p, 360p, 720p, 1080p), each with different bitrates.

2. **Manifest File**
   - The server provides a manifest file:
     - **In HLS**: A `.m3u8` file that contains links to video segments for each quality level.

3. **Segments**
   - The video is divided into short segments, typically 2–10 seconds long.

4. **Dynamic Switching**
   - The client (e.g., `AVQueuePlayer`) dynamically adjusts playback quality based on the current internet speed:
     - Starts playback with the most suitable quality.
     - Switches to higher or lower quality during playback as the connection speed changes.

### Why This is the Best Option

- **On-the-fly quality adjustment**: Ensures smooth transitions between quality levels without interrupting playback.
- **Minimal pauses and interruptions**: Reduces buffering and improves user experience.
- **Bandwidth efficiency**: The server sends only the appropriate stream, saving network traffic.

## AVQueuePlayer features out of the box

In the core of this package, I use `AVQueuePlayer`. Here are the supported features that are automatically enabled by `AVQueuePlayer` without passing any extra parameters:

| Feature                                                                                                    | Description                                                                                                                                      |
|------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| **Hardware accelerator**                                                                                   | `AVQueuePlayer` uses hardware acceleration by default where available.                                                                            |
| **4k/HDR/HDR10/HDR10+/Dolby Vision**                                                                       | These high-definition and high-dynamic-range formats are natively supported by `AVQueuePlayer`.                                                   |
| **Multichannel Audio/Dolby Atmos/Spatial Audio**                                                           | `AVQueuePlayer` supports advanced audio formats natively.                                                                                         |
| **Text subtitle/Image subtitle/Closed Captions**                                                           | Subtitle and caption tracks included in the video file are automatically detected and rendered.                                                   |
| **Automatically switch to multi-bitrate streams based on network**                                         | Adaptive bitrate streaming is handled automatically by `AVQueuePlayer` when streaming from a source that supports it.                             |
| **External playback control support**                                                                      | Supports playback control through external accessories like headphones and Bluetooth devices.                                                     |
| **AirPlay support**                                                                                        | Natively supports streaming audio and video via AirPlay to compatible devices without additional setup.                                           |
| **Background Audio Playback**                                                                              | Continues audio playback when the app is in the background, provided the appropriate audio session category is set.                               |
| **Picture-in-Picture (PiP) Support**                                                                       | Enables Picture-in-Picture mode on compatible devices without additional setup.                                                                   |
| **HLS (HTTP Live Streaming) Support**                                                                      | Natively supports streaming of HLS content for live and on-demand playback.                                                                       |
| **FairPlay DRM Support**                                                                                   | Can play FairPlay DRM-protected content.                                                                                 |
| **Now Playing Info Center Integration**                                                                    | Automatically updates the Now Playing Info Center with current playback information for lock screen and control center displays.                  |
| **Remote Control Event Handling**                                                                          | Supports handling remote control events from external accessories and system controls.                                                            |
| **Custom Playback Rate**                                                                                   | Allows setting custom playback rates for slow-motion or fast-forward playback without additional configuration.                                   |
| **Seamless Transition Between Items**                                                                      | Provides smooth transitions between queued media items, ensuring continuous playback without gaps.                                                |
| **Automatic Audio Session Management**                                                                     | Manages audio sessions to handle interruptions (like phone calls) and route changes appropriately.                                                |
| **Subtitles and Closed Caption Styling**                                                                   | Supports user preferences for styling subtitles and closed captions, including font size, color, and background.                                   |
| **Audio Focus and Ducking**                                                                                | Handles audio focus by pausing or lowering volume when necessary, such as when a navigation prompt plays.                                         |
| **Metadata Handling**                                                                                      | Reads and displays metadata embedded in media files, such as song titles, artists, and artwork.                                                   |
| **Buffering and Caching**                                                                                  | Efficiently manages buffering of streaming content to reduce playback interruptions.                                                              |
| **Error Handling and Recovery**                                                                            | Provides built-in mechanisms to handle playback errors and attempt recovery without crashing the application.                                     |
| **Accessibility Features**                                                                                 | Supports VoiceOver and other accessibility features to make media content accessible to all users.                                                |

