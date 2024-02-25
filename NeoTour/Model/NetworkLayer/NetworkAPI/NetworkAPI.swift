//
//  NetworkAPI.swift
//  NeoTour
//
//  Created by anjella on 25/2/24.
//

import UIKit
import Alamofire

enum NetworkAPI {
    
    // MARK: - GET
    case getTourCategoryList
    case getTourList
    case getTourDetails(tourID: String)
    
    // MARK: - POST
    case addReservation(tourID: String,
                        phoneNumber: String,
                        reservationComment: String,
                        numberOfPeople: Int)
    
    var host: String {
        "164.92.239.214:9999"
    }
    
    var path: String {
        switch self {
        case .getTourList:
            return "/neotour/tours"
        case .getTourCategoryList:
            return "/neotour/categories"
        case .getTourDetails(tourID: let tourID):
            return "/neotour/tours/\(tourID)"
        case .addReservation(tourID: let tourID, phoneNumber: let phoneNumber, reservationComment: let reservationComment, numberOfPeople: let numberOfPeople):
            return "/neotour/tours/{id}/addReservation"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTourList, .getTourCategoryList, .getTourDetails:
            return .get
        case .addReservation:
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getTourList, .getTourCategoryList, .getTourDetails:
            return nil
        case .addReservation(let tourID, let phoneNumber, let reservationComment, let numberOfPeople):
            return [
                "id": tourID,
                "phoneNumber": phoneNumber,
                "reservationComment": reservationComment,
                "numberOfPeople": numberOfPeople
            ]
        }
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        components.host = host
        components.path = path
        
        return components
    }
}
