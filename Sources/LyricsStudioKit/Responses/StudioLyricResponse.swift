// Made by Lumaa

import Foundation

public struct StudioLyricResponse: Identifiable, Decodable {
    public let id: Int
    public let trackId: String
    public let trackName: String
    public let artistName: String
    public let albumName: String
    public let trackDuration: TimeInterval
    public let ttml: String
    public let language: String
    public let writers: [String]
    public let syncType: Self.SyncType
    public let source: String
    public let accessCount: Int
    public let submittedBy: Int?

    public init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Self.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.trackId = try container.decode(String.self, forKey: .trackId)
        self.trackName = try container.decode(String.self, forKey: .trackName)
        self.artistName = try container.decode(String.self, forKey: .artistName)
        self.albumName = try container.decode(String.self, forKey: .albumName)
        self.trackDuration = try container.decode(TimeInterval.self, forKey: .trackDuration)
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
}
