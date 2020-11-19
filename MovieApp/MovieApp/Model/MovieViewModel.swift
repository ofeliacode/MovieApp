//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Офелия Баширова on 18.11.2020.
//

import Foundation

class MovieViewModel {
    private var moviesManager = MovieManager()
    private var movies        = [Movie]()
    
    func fetchMoviesData(comletion: @escaping () -> ()) {
        moviesManager.request { (result) in
            switch result {
            case .success(let listOf):
                self.movies = listOf.results
                comletion()
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
