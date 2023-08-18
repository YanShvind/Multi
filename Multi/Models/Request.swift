
import Foundation
import UIKit

final class Request {
    static let shared = Request()
    
    func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func getLocationById(id: Int, completion: @escaping (Result<Location, Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/location/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let location = try JSONDecoder().decode(Location.self, from: data)
                completion(.success(location))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getEpisodesForCharacter(characterName: String, completion: @escaping (Result<[Episode], Error>) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                guard let character = characterResponse.results.first(where: { $0.name == characterName }) else {
                    completion(.failure(NSError(domain: "Character not found", code: -1, userInfo: nil)))
                    return
                }
                
                let dispatchGroup = DispatchGroup()
                var episodes: [Episode] = []
                
                for episodeURL in character.episode {
                    dispatchGroup.enter()
                    
                    let episodeURL = URL(string: episodeURL)!
                    
                    URLSession.shared.dataTask(with: episodeURL) { (data, response, error) in
                        defer { dispatchGroup.leave() }
                        
                        if let error = error {
                            print("Episode request error: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let data = data else {
                            print("No episode data received")
                            return
                        }
                        
                        do {
                            let episode = try JSONDecoder().decode(Episode.self, from: data)
                            episodes.append(episode)
                        } catch {
                            print("Episode decoding error: \(error.localizedDescription)")
                        }
                    }.resume()
                }
                
                dispatchGroup.notify(queue: .main) {
                    completion(.success(episodes))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Image error: \(error)")
                completion(nil)
                return
            }
            
            if let imageData = data, let image = UIImage(data: imageData) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
