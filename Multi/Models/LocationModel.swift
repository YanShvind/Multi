
import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
}

struct LocationResponse: Codable {
    let results: [Location]
}
