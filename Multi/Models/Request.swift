
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
