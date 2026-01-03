// Made by Lumaa

import Foundation
import MusicKit

public final class LyricsStudio {
    /// Fetches all of Cider's Lyric Studio with the matching id
    public static func fetchAllLyrics(for id: String) async throws -> [StudioLyricResponse] {
        guard let url = URL(string: "https://taproom.cider.sh/api/v1/lyrics/track/\(id)/all") else { throw LyricsStudioError.badURL(nil) }

        var req: URLRequest = .init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
        req.httpMethod = "GET"

        let response = try await URLSession.shared.data(for: req)
        if let http = response.1 as? HTTPURLResponse, http.statusCode > 299 {
            throw LyricsStudioError.responseError(String(data: response.0, encoding: .utf8))
        }

        let json = JSONDecoder()
        let allResponse = try json.decode(StudioTrackAllResponse.self, from: response.0)
        return allResponse.lyrics
    }

    /// Fetches all of Cider's Lyric Studio for the `track`
    public static func fetchAllLyrics(for track: Track) async throws -> [StudioLyricResponse] {
        return try await self.fetchAllLyrics(for: track.id.rawValue)
    }
}
