import UIKit

enum NetworkError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case decodeError(String)
}

protocol LocalServicesProtocol {
    func searchApps(text: String, completion: @escaping (Result<[App], Error>) -> Void)
}

class Service: LocalServicesProtocol {
    func searchApps(text: String, completion: @escaping (Result<[App], Error>) -> Void) {
        guard let url = URL(string: "http://localhost/app-store/v1/apps?search=\(text)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if 200...299 ~= response.statusCode {
                guard let data = data else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                
                do {
                    let appData = try JSONDecoder().decode([App].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(appData))
                    }
                } catch {
                    completion(.failure(NetworkError.decodeError(error.localizedDescription)))
                }
            }
        }.resume()
    }
}
