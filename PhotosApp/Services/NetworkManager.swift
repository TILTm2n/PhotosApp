//
//  APIManager.swift
//  PhotosApp
//
//  Created by Eugene on 10.06.2022.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func fetchPhotos(with query: String, completion: @escaping (Result<[Item], Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    func fetchPhotos(with query: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos?query=\(query)&client_id=-4ZVq_VXWDm8N1htR4MivXojwOQ3QCvzLpiJ1ydfBEY&per_page=30"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data!)
                completion(.success(apiResponse.results))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
}
