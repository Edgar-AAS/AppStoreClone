import Foundation

protocol AppServiceProtocol {
    func fetchFeaturedApps(completion: @escaping (Result<[FeaturedApp], Error>) -> Void)
}

//criar uma requisicao genérica ou um handler de endpoints
class AppService: AppServiceProtocol {
    private let urlBase = "http://localhost/app-store/v1"
    
    func fetchFeaturedApps(completion: @escaping (Result<[FeaturedApp], Error>) -> Void) {
        guard let url = URL(string: "\(urlBase)/apps/apps-em-destaque") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                    let featureApps = try JSONDecoder().decode([FeaturedApp].self, from: data)
                    completion(.success(featureApps))
                } catch {
                    completion(.failure(NetworkError.decodeError(error.localizedDescription)))
                }
            }
        }.resume()
    }
    
    
    func fetchGroup(type: String, completion: @escaping (Result<AppGroup, Error>) -> Void) {
        guard let url = URL(string: "\(urlBase)/apps/\(type)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                    let appGroups = try JSONDecoder().decode(AppGroup.self, from: data)
                    completion(.success(appGroups))
                } catch {
                    completion(.failure(NetworkError.decodeError(error.localizedDescription)))
                }
            }
        }.resume()
    }
    
    
    func fetchAppId(appId: Int, completion: @escaping (Result<App, Error>) -> Void) {
        guard let url = URL(string: "\(urlBase)/apps/\(appId)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                    let appId = try JSONDecoder().decode(App.self, from: data)
                    completion(.success(appId))
                } catch {
                    completion(.failure(NetworkError.decodeError(error.localizedDescription)))
                }
            }
        }.resume()
    }
    
    
    func fetchApp(completion: @escaping ([App]?, Error?) -> Void) {
        guard let url = URL(string: "\(urlBase)/apps") else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NetworkError.invalidResponse)
                return
            }
            
            if 200...299 ~= response.statusCode {
                guard let data = data else {
                    completion(nil, NetworkError.invalidData)
                    return
                }
                
                do {
                    let apps = try JSONDecoder().decode([App].self, from: data)
                    completion(apps, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
