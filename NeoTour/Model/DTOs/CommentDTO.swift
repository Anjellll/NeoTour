//
//  CommentDTO.swift
//  NeoTour
//
//  Created by anjella on 25/2/24.
//

import Foundation

// MARK: - Comment
struct Comment: Codable {
    let commentID, commentUsername, commentText: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case commentID = "commentId"
        case commentUsername, commentText
        case imageURL = "imageUrl"
    }
}
