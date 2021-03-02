//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Vlad Novik on 27.02.21.
//

import Foundation
import CoreLocation

protocol NetworkServiceProtocol: class {
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func request<T>(router: Router, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable, T : Encodable {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        let urlRequest = URLRequest(url: url)
        
        print(url)
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            
            let responseObject = try? JSONDecoder().decode(T.self, from: data)
            
            DispatchQueue.main.async {
                if let responseObject = responseObject {
                    completion(.success(responseObject))
                }
            }
        }
        dataTask.resume()
    }
}
