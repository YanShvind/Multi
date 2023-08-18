
import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let image: String
    let episode: [String]
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct CharacterResponse: Codable {
    let results: [Character]
}
