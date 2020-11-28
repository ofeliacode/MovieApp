//
//  MovieManager.swift
//  MovieApp
//
//  Created by Офелия Баширова on 30.10.2020.
//

import Foundation
import RealmSwift
import Realm

struct MovieManager {
    
    mutating func request(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let urlString =
        "https://api.themoviedb.org/3/movie/popular?api_key=dfc41d3d13bc64503f9270485fa8746f&page=1"
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
                    completion(.success(movies))
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}

