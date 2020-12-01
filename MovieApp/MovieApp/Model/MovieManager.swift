//
//  MovieManager.swift
//  MovieApp
//
//  Created by Офелия Баширова on 30.10.2020.
//

import Foundation
import RealmSwift
import Realm
class MovieManager {
    func request(from urlString: String, completion: @escaping (Result<MoviesData, Error>) -> Void) {
        guard let url = URL(string: urlString) else {return}
         URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                do {
                    let movies = try JSONDecoder().decode(MoviesData.self, from: data)
                    print("moviemanger duties:\(movies)")
                    completion(.success(movies))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}

