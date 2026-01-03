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
        "1796149669"
    ]

    @Test("Fetch lyrics for active test ids", arguments: LyricsStudioKitTests.testActiveIds)
    func fetchTestActiveLyrics(id: String) async throws {
        do {
            let lyrics = try await LyricsStudio.fetchAllLyrics(for: id)
            #expect(!lyrics.isEmpty)
        } catch {
            print(error)
        }
    }
}
