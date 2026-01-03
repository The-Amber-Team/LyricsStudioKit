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

    /// Fetches the most appropriate Cider lyrics with the matching id
    ///
    /// Cider provides a `exp-rise.cider.sh` endpoint to fetch lyrics for a given Apple Music track id. It is unknown how this endpoint works in harmony with the [Lyrics Studio on Taproom](https://taproom.cider.sh/lyrics), but it does. Though it might be better to use the ``fetchAllLyrics(for: String)`` function and manually get the most viewed lyrics.
    ///
    /// This function also increments the ``StudioLyricResponse/accessCount``.
    ///
    /// - Returns: A privately Cider-chosen ``StudioLyricResponse``
    /// - Throws: May throw multiple errors:
    ///     - ``LyricsStudioError/badURL(_:)`` - The URL with the `id` is malformed or incorrect
    ///     - ``LyricsStudioError/responseError(_:)`` - The HTTP response gave back an error
    public static func fetchLyrics(for id: String) async throws -> StudioLyricResponse {
        guard let url = URL(string: "https://exp-rise.cider.sh/api/v1/lyrics/user/\(id)") else { throw LyricsStudioError.badURL(nil) }

        var req: URLRequest = .init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
        req.httpMethod = "GET"

        let response = try await URLSession.shared.data(for: req)
        if let http = response.1 as? HTTPURLResponse, http.statusCode > 299 {
            throw LyricsStudioError.responseError(String(data: response.0, encoding: .utf8))
        }

        let json = JSONDecoder()
        let allResponse = try json.decode(StudioLyricResponse.self, from: response.0)
        return allResponse
    }

    /// Fetches all of Cider's Lyrics Studio with the matching id
    ///
    /// - Returns: Community-made array of  ``StudioLyricResponse``
    /// - Throws: May throw multiple errors:
    ///     - ``LyricsStudioError/badURL(_:)`` - The URL with the `id` is malformed or incorrect
    ///     - ``LyricsStudioError/responseError(_:)`` - The HTTP response gave back an error
    public static func fetchAllLyrics(for track: Track) async throws -> [StudioLyricResponse] {
        return try await self.fetchAllLyrics(for: track.id.rawValue)
    }
}
