//
//  TVResponseEntity.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

struct TVResponseEntity: Codable {
    let results: [TVResponseResult]?
}

struct TVResponseResult: Codable {
    let backdropPath: String?
    let firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let name: String?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
