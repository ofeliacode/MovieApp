//
//  MovieData.swift
//  MovieApp
//
//  Created by Офелия Баширова on 11.11.2020.
//

import Foundation

struct MoviesData: Codable {
    let pages: Int
    let results: [Movie]
    private enum CodingKeys: String, CodingKey {
        case pages = "total_pages"
        case results
    }
}
struct Movie: Codable {
    let title: String?
    let year: String?
    let posterImage: String?
    let overview: String?
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case posterImage = "poster_path"
    }
}
