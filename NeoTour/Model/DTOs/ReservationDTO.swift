//
//  ReservationDTO.swift
//  NeoTour
//
//  Created by anjella on 25/2/24.
//

import Foundation

// MARK: - Reservation
struct Reservation: Codable {
    let reservationID: String
    let phoneNumber: String?
    let reservationComment: String?
    let numberOfPeople: Int?

    enum CodingKeys: String, CodingKey {
        case reservationID = "reservationId"
        case phoneNumber, reservationComment, numberOfPeople
    }
}
