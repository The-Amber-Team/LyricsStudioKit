# LyricsStudioKit

Fetch lyrics from Cider's Lyrics Studio

## Usage

Simple as it is:

```swift
import MusicKit

// Fetches the most viewed lyrics out of them all
func getBestLyrics() async throws -> StudioLyricResponse {
    let trackId: String = "1683380777" // i remember - bbno$

    // Fetch lyrics from Lyrics Studio
    let allLyrics: [StudioLyricResponse] = try await LyricsStudio.fetchAllLyrics(for: trackId)

    guard !allLyrics.isEmpty else { fatalError("No lyrics for \(trackId)") }
    return allLyrics.sorted(by: { $0.accessCount > $1.accessCount })[0]
}
```

## Copyright
© Lumaa 2026
