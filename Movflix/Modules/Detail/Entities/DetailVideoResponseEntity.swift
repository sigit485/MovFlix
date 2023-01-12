//
//  DetailVideoResponseEntity.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

struct DetailVideoResponseEntity: Codable {
    let results: [DetailVideoResult]?
}

struct DetailVideoResult: Codable {
    let iso639_1: String?
    let iso3166_1: String?
    let name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
