
import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episodeCode: String
    let characters: [String]
    let url: String
    let created: String

    private enum CodingKeys: String, CodingKey {
        case id, name, airDate = "air_date", episodeCode = "episode", characters, url, created
    }
}

struct EpisodeResponse: Codable {
    let episode: [Episode]
}
