
import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episodeCode: String

    private enum CodingKeys: String, CodingKey {
        case id, name, airDate = "air_date", episodeCode = "episode"
    }
}

struct EpisodeResponse: Codable {
    let episode: [Episode]
}
