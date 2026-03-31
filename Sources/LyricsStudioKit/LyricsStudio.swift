// Made by Lumaa

import Foundation
import OSLog
import MusicKit

public final class LyricsStudio {
	private static let logger: Logger = .init(subsystem: "LyricsStudioKit", category: "Fetch")

    /// Fetches all of Cider's Lyrics Studio with the matching id
	///
	/// This method uses the `taproom.cider.sh` URL, which often throws ``LyricsStudioError/responseError(_:)`` than its counter part ``fetchAllLyrics(with:)``.
    ///
    /// - Returns: Community-made array of  ``StudioLyricResponse``
    /// - Throws: May throw multiple errors:
    ///     - ``LyricsStudioError/badURL(_:)`` - The URL with the `id` is malformed or incorrect
    ///     - ``LyricsStudioError/responseError(_:)`` - The HTTP response gave back an error
	@available(*, deprecated, renamed: "fetchAllLyrics(with:)", message: "Cider put a verification behind this endpoint which causes an `responseError`.")
    public static func fetchAllLyrics(for id: MusicItemID) async throws -> [StudioLyricResponse] {
		guard let url = URL(string: "https://taproom.cider.sh/api/v1/lyrics/track/\(id.rawValue)/all") else { throw LyricsStudioError.badURL(nil) }
		logger.warning("Using deprecated URL might throw an error. Use `fetchAllLyrics(with:)`.")

        var req: URLRequest = .init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
        req.httpMethod = "GET"

        let response = try await URLSession.shared.data(for: req)
		if let http = response.1 as? HTTPURLResponse, (200...299).contains(http.statusCode) {
            throw LyricsStudioError.responseError(String(data: response.0, encoding: .utf8))
        }

        let json = JSONDecoder()
        let allResponse = try json.decode(StudioTrackAllResponse.self, from: response.0)
        return allResponse.lyrics
    }

    /// Fetches the most appropriate Cider lyrics with the matching id
    ///
	/// Using this method, causes the lyrics' view count to go one up in Taproom.
	///
    /// Cider provides a `exp-rise.cider.sh` endpoint to fetch lyrics for a given Apple Music track id. It is unknown how this endpoint works in harmony with the [Lyrics Studio on Taproom](https://taproom.cider.sh/lyrics).
    ///
    /// - Returns: A privately Cider-chosen ``StudioLyricResponse``
    /// - Throws: May throw multiple errors:
    ///     - ``LyricsStudioError/badURL(_:)`` - The URL with the `id` is malformed or incorrect
    ///     - ``LyricsStudioError/responseError(_:)`` - The HTTP response gave back an error
    public static func fetchLyrics(for id: MusicItemID) async throws -> StudioLyricResponse {
		guard let url = URL(string: "https://exp-rise.cider.sh/api/v1/lyrics/user/\(id.rawValue)") else { throw LyricsStudioError.badURL(nil) }

        var req: URLRequest = .init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
        req.httpMethod = "GET"

        let response = try await URLSession.shared.data(for: req)
		if let http = response.1 as? HTTPURLResponse, (200...299).contains(http.statusCode) {
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
	public static func fetchAllLyrics(with id: MusicItemID) async throws -> [StudioLyricResponse] {
		guard let url = URL(string: "https://exp-rise.cider.sh/api/v1/lyrics/user/\(id.rawValue)/all") else { throw LyricsStudioError.badURL(nil) }

		var req: URLRequest = .init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
		req.httpMethod = "GET"

		let response = try await URLSession.shared.data(for: req)
		if let http = response.1 as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
			throw LyricsStudioError.responseError(String(data: response.0, encoding: .utf8))
		}

		let json = JSONDecoder()
		let allResponse = try json.decode(StudioTrackAllResponse.self, from: response.0)
		return allResponse.lyrics
	}
}
