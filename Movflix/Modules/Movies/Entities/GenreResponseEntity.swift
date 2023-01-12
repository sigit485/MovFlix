//
//  GenreResponseEntity.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

struct GenreResponseEntity: Codable {
    let genres: [GenreResult]?
}

// MARK: - Genre
struct GenreResult: Codable {
    let id: Int?
    let name: String?
}
