//
//  ReviewsModel.swift
//  NeoTour
//
//  Created by anjella on 21/2/24.
//

import Foundation

struct ReviewsModel {
    let userIcon: String
    let userName: String
    let userReview: String
    
    static func getReviews() -> [ReviewsModel] {
        return [ReviewsModel(userIcon: "userIcon", userName: "Anonymous", userReview: "That was such a nice place. The most beautiful place I’ve ever seen. My advice to everyone not to forget to take warm coat"),ReviewsModel(userIcon: "userIcon", userName: "Anonymous", userReview: "That was such a nice place. The most beautiful place I’ve ever seen. My advice to everyone not to forget to take warm coat"),ReviewsModel(userIcon: "userIcon", userName: "Anonymous", userReview: "That was such a nice place. The most beautiful place I’ve ever seen. My advice to everyone not to forget to take warm coat")]
    }
}
