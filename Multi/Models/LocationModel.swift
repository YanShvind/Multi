
import Foundation

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
}

struct LocationResponse: Codable {
    let results: [Location]
}
