//
//  DetailTVResponseEntity.swift
//  Movflix
//
//  Created by Sigit on 13/01/23.
//

import Foundation

struct DetailTVResponseEntity: Codable {
    let adult: Bool?
    let backdropPath: String?
    let firstAirDate: String?
    let id: Int?
    let inProduction: Bool?
    let lastAirDate: String?
    let name: String?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let status, tagline, type: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case id
        case inProduction = "in_production"
        case lastAirDate = "last_air_date"
        case name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
