// Made by Lumaa

import Testing
@testable import LyricsStudioKit

struct LyricsStudioKitTests {
    /// Test IDs with `lyrics` not empty
    static let testActiveIds: [String] = [
        "1849179991",
        "1742010853",
        "1721171510",
        "1863593386",
        "1861830402",
        "1770571677",
        "1796149669",
        "1858973322"
    ]

    @Test("Fetch lyrics for active test ids", arguments: LyricsStudioKitTests.testActiveIds)
    func fetchTestActiveLyrics(id: String) async throws {
        do {
            let lyrics = try await LyricsStudio.fetchAllLyrics(for: id)
            #expect(lyrics[0].id > 0 && !lyrics.isEmpty)
        } catch {
            print(error)
        }
    }

    @Test("Best lyrics for active test ids", arguments: LyricsStudioKitTests.testActiveIds)
    func getBestLyrics(id: String) async throws {
        do {
            let lyrics = try await LyricsStudio.fetchAllLyrics(for: id)
            try #require(!lyrics.isEmpty)

            let best = lyrics.sorted(by: >)[0] // using `Comparable`
            let theoBest = lyrics.sorted(by: { $0.accessCount > $1.accessCount })[0] // theoretical best, using actual var
            #expect(best == theoBest)
        } catch {
            print(error)
        }
    }
}
