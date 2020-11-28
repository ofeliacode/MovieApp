//
//  MovieData.swift
//  MovieApp
//
//  Created by Офелия Баширова on 11.11.2020.
//

import Foundation
import Realm
import RealmSwift

class MoviesData: Object, Codable {
    @objc dynamic var pages: Int
    var results = Array<Movie>()
    private enum CodingKeys: String, CodingKey {
        case pages = "total_pages"
        case results
    }
}
class Movie: Object, Codable {
    @objc dynamic var title: String?
    @objc dynamic var year: String?
    @objc dynamic var posterImage: String?
    @objc dynamic var overview: String?
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case posterImage = "poster_path"
    }
}

