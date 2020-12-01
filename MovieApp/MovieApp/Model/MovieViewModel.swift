//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Офелия Баширова on 18.11.2020.
//

import Foundation
import RealmSwift
class MovieViewModel {
   var moviesManager = MovieManager()
   var movies        = [Movie]()
    
    func fetchMoviesData(url: String, comletion: @escaping () -> ()) {
        moviesManager.request(from: url) { (result) in
            print("MovieViewModel result:\(result)")
            switch result {
            case .success(let listOf):
                print("listOf means: \(listOf)")
                self.movies = listOf.results
                print("MovieViewModel duties:\(self.movies)")
                comletion()
                print("completiom means: \(comletion())")
            case .failure(let error):
                print(error)
            }
        }
      
    }
    
    func loadMoreMovies(url: String, comletion: @escaping () -> ()) {
        moviesManager.request(from: url) { (result) in
            print("MovieViewModel result:\(result)")
            switch result {
            case .success(let listOf):
                print("listOf means: \(listOf)")
                self.movies.append(contentsOf: listOf.results)
                print("fetchMoviesDataPaging duties:\(self.movies)")
                comletion()
                print("completiom means: \(comletion())")
            case .failure(let error):
                print(error)
            }
        }
      
    }
    
    
    func numberOfRowInSections(section: Int) -> Int {
        if movies.count != 0 {
            return movies.count
        }
        return 0
    }
    func cellForRowAt(indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
}
