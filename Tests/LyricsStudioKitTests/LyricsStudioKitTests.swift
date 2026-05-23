// Made by Lumaa

import Testing
import MusicKit
@testable import LyricsStudioKit

struct LyricsStudioKitTests {
    /// Test IDs with `lyrics` not empty
    static let testActiveIds: [String] = [
        "1849179991",
        "1742010853",
        "1721171510",
        "1863593386",
		"1834233575"
    ]

	@Test("Fetch preferred lyrics for active test ids", arguments: LyricsStudioKitTests.testActiveIds)
	func fetchTestActiveLyric(id: String) async throws {
		let lyrics = try await LyricsStudio.fetchLyrics(for: MusicItemID(rawValue: id))
		#expect(lyrics.ttml.count > 0)
	}

    @Test("Fetch lyrics for active test ids", arguments: LyricsStudioKitTests.testActiveIds)
    func fetchTestActiveLyrics(id: String) async throws {
		let lyrics = try await LyricsStudio.fetchAllLyrics(with: MusicItemID(rawValue: id))
		#expect(lyrics[0].id > 0 && !lyrics.isEmpty)
    }

    @Test("Best lyrics for active test ids", arguments: LyricsStudioKitTests.testActiveIds)
    func getBestLyrics(id: String) async throws {
		let lyrics = try await LyricsStudio.fetchAllLyrics(with: MusicItemID(rawValue: id))
		try #require(!lyrics.isEmpty)

		let best = lyrics.sorted(by: >)[0] // using `Comparable`
		let theoBest = lyrics.sorted(by: { $0.accessCount > $1.accessCount })[0] // theoretical best, using actual var
		#expect(best == theoBest)
    }
}
