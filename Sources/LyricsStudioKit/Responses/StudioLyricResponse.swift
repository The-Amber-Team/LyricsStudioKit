// Made by Lumaa

import Foundation

public struct StudioLyricResponse: Identifiable, Decodable, Equatable, Comparable {
    /// The submitted lyric identifier
    public let id: Int

    /// The Apple Music track identifier
    public let trackId: String

    public let trackName: String
    public let artistName: String
    public let albumName: String

    /// The duration of the track in seconds, converted from milliseconds
    public let trackDuration: TimeInterval

    /// The lyrics' TTML
    public let ttml: String

    public let language: String

    /// The track's lyrics' writers
    /// - Note: This is not the author of the submitted lyrics
    public let writers: [String]

    public let syncType: Self.SyncType
    public let source: String

    /// The number of views this submitted lyrics has in total
    public let accessCount: Int

    public let submittedBy: Int?

    public init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Self.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.trackId = try container.decode(String.self, forKey: .trackId)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.albumName = try container.decode(String.self, forKey: .albumName)
        self.trackDuration = try container.decode(TimeInterval.self, forKey: .trackDuration) / 1000
        self.ttml = try container.decode(String.self, forKey: .ttml)
        self.language = try container.decode(String.self, forKey: .language)
        self.writers = try container.decode([String].self, forKey: .writers)
        self.syncType = try container.decode(StudioLyricResponse.SyncType.self, forKey: .syncType)
        self.source = try container.decode(String.self, forKey: .source)
        self.accessCount = try container.decode(Int.self, forKey: .accessCount)

        let submittedStr: String? = try container.decodeIfPresent(String.self, forKey: .submittedBy)
        self.submittedBy = submittedStr != nil ? Int(submittedStr!) : nil
    }

    public enum CodingKeys: CodingKey {
        case id
        case trackId
        case trackName
        case artistName
        case albumName
        case trackDuration
        case ttml
        case language
        case writers
        case syncType
        case source
        case accessCount
        case submittedBy
    }

    public enum SyncType: String, Decodable {
        case beatByBeat = "syllable"
        case lineByLine = "line"
    }

    public static func >(lhs: Self, rhs: Self) -> Bool {
        return lhs.accessCount > rhs.accessCount
    }

    public static func >=(lhs: Self, rhs: Self) -> Bool {
        return lhs.accessCount >= rhs.accessCount
    }

    public static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.accessCount < rhs.accessCount
    }

    public static func <=(lhs: Self, rhs: Self) -> Bool {
        return lhs.accessCount <= rhs.accessCount
    }

    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
