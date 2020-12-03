//
//  MovieData.swift
//  MovieApp
//
//  Created by Офелия Баширова on 11.11.2020.
//

import Foundation

struct MoviesData: Codable {
    var results: [Movie]
}
struct Movie:  Codable {
   var title: String?
   var year: String?
   var posterImage: String?
   var overview: String?
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case posterImage = "poster_path"
    }
}

