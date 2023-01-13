//
//  DetailReviewResponseEntity.swift
//  Movflix
//
//  Created by Sigit on 13/01/23.
//

import Foundation

struct DetailReviewResponseEntity: Codable {
    let results: [DetailReviewResult]?
}

struct DetailReviewResult: Codable {
    let author: String?
    let authorDetails: DetailReviewAuthorDetails?
    let content, createdAt, id, updatedAt: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

struct DetailReviewAuthorDetails: Codable {
    let name, username: String?
    let avatarPath: String?
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
