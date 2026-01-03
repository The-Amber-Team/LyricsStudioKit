// Made by Lumaa

import Foundation

public struct StudioTrackAllResponse: Decodable {
    /// The total amount of lyrics for that ``trackId``
    public let count: Int
    public let lyrics: [StudioLyricResponse]
    /// The Apple Music track identifier
    public let trackId: String

    public init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Self.CodingKeys> = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.lyrics = try container.decode([StudioLyricResponse].self, forKey: .lyrics)
        self.trackId = try container.decode(String.self, forKey: .trackId)
    }

    public enum CodingKeys: CodingKey {
        case count
        case lyrics
        case trackId
    }
}
