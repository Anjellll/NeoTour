//
//  NetworkAPI.swift
//  NeoTour
//
//  Created by anjella on 25/2/24.
//

import UIKit
import Alamofire

import Alamofire

enum NetworkAPI {
    
    // MARK: - GET
    case getTourCategoryList
    case getTourList
    
    // MARK: - POST
    case addReservation(tourID: String,
                        phoneNumber: String,
                        reservationComment: String,
                        numberOfPeople: Int)

    // MARK: - Properties
    private var scheme: String {
        return "http"
    }
    
    private var host: String {
        return "164.92.239.214"
    }
    
    private var port: Int {
        return 9999
    }
    
    private var path: String {
        switch self {
        case .getTourCategoryList:
            return "/neotour/categories"
        case .getTourList:
            return "/neotour/tours"
        case .addReservation(let tourID, _, _, _):
            return "/neotour/tours/\(tourID)/addReservation"
        }
    }
    
    internal var method: HTTPMethod {
        switch self {
        case .getTourCategoryList, .getTourList:
            return .get
        case .addReservation:
            return .post
        }
    }
    
    internal var parameters: Parameters? {
        switch self {
        case .addReservation(let tourID, let phoneNumber, let reservationComment, let numberOfPeople):
            return ["tourID": tourID,
                    "phoneNumber": phoneNumber,
                    "reservationComment": reservationComment,
                    "numberOfPeople": numberOfPeople]
        default:
            return nil
        }
    }
    
    var url: URL? {
        var components = components
        components.queryItems = parameters?.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        return components.url
    }

    private var components: URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        
        return components
    }
}
