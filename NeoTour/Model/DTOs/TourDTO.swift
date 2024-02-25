//
//  TourDTO.swift
//  NeoTour
//
//  Created by anjella on 25/2/24.
//

import Foundation

// MARK: - TourDTO
struct TourDTO: Codable, Hashable {
    let tourID, tourName, tourDescription, tourLocation: String?
    let comments: [Comment]
    let imageURL: String?
    let reservations: [Reservation]
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: TourDTO, rhs: TourDTO) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()

    enum CodingKeys: String, CodingKey {
        case tourID = "tourId"
        case tourName, tourDescription, tourLocation, comments
        case imageURL = "imageUrl"
        case reservations
    }
}


