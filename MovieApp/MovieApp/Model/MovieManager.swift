//
//  MovieManager.swift
//  MovieApp
//
//  Created by Офелия Баширова on 30.10.2020.
//

import Foundation

class MovieManager {
    
    func request(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
         URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                completion(.success(data))
            }
        }.resume()
    }
}


