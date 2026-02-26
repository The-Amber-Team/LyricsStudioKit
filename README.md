<div align="center">
    <h1>LyricsStudioKit</h1>
    <img width=128 height=128 src="./data/LyricsStudioKit_Icon.png" alt="LyricsStudioKit Icon"/>
</div>

Fetch lyrics from [Cider](https://cider.sh/)'s Lyrics Studio

## Usage

Simple as it is:

```swift
import MusicKit
import LyricsStudioKit

// Fetches the most viewed lyrics out of them all
func getBestLyrics() async throws -> StudioLyricResponse {
    let trackId: String = "1683380777" // i remember - bbno$

    // Fetch lyrics from Lyrics Studio
    let allLyrics: [StudioLyricResponse] = try await LyricsStudio.fetchAllLyrics(for: trackId)

    guard !allLyrics.isEmpty else { fatalError("No lyrics for \(trackId)") }
    return allLyrics.sorted(by: >)[0]
}
```

## Copyright
© Amber Team 2026
