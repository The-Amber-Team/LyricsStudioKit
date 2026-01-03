// Made by Lumaa

import Foundation

public enum LyricsStudioError: Error {
    case badURL(String?)
    case responseError(String?)

    var description: String? {
        switch self {
            case .badURL(let string), .responseError(let string):
                return string
        }
    }
}
