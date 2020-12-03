//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Офелия Баширова on 18.11.2020.
//

import Foundation

class MovieViewModel {
   private var moviesManager = MovieManager()
   private let urlScheme = "https"
   private let urlHost = "api.themoviedb.org"
    
    //load movies for main screen
    func fetchMoviesForCollectionView(pageNumber: Int, completion: @escaping (MoviesData?) -> Void) {

        var components = URLComponents()
        components.scheme = urlScheme
        components.host = urlHost
        components.path = "/3/movie/popular"
        components.queryItems = [URLQueryItem(name: "api_key", value: "dfc41d3d13bc64503f9270485fa8746f"),
                                 URLQueryItem(name: "page", value: "\(pageNumber)")]
    
        guard let url = components.url else { return }
        print(url)
        moviesManager.request(from: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(MoviesData.self, from: data)
                    completion(movie)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    //loading movies by search request
    func fetchResultOfSearchBar(searchText: String, pageNumber: Int, completion: @escaping (MoviesData?) -> Void) {

        var components = URLComponents()
        components.scheme = urlScheme
        components.host = urlHost
        components.path = "/3/search/movie"
        components.queryItems = [URLQueryItem(name: "api_key", value: "dfc41d3d13bc64503f9270485fa8746f"),
                                 URLQueryItem(name: "query", value: searchText),
                                 URLQueryItem(name: "page", value: "\(pageNumber)")]
        guard let url = components.url else { return }
        moviesManager.request(from: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(MoviesData.self, from: data)
                    completion(movie)
                } catch let jsonError {
                    print("Failed to decode JSON (fetchResultOfSearch)", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

   /* // fetch detail info about selected movie
    func fetchDetailsInfoOfSelectedMovie(movieId: Int, completion: @escaping (MovieDetails?) -> Void) {

        var components = URLComponents()
        components.scheme = urlScheme
        components.host = urlHost
        components.path = "/3/movie/\(movieId)"
        components.queryItems = [URLQueryItem(name: "api_key", value: "2d41304b77814da190f8a45c885b901b"),
                                 URLQueryItem(name: "append_to_response", value: "credits")]
        guard let url = components.url else { return }
        networkService.request(url: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(MovieDetails.self, from: data)
                    completion(movie)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
*/
}
