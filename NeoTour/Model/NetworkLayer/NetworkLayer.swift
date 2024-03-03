//
//  NetworkLayer.swift
//  NeoTour
//
//  Created by anjella on 14/2/24.
//

import UIKit
import Alamofire

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    private init() { }
    
    func fetchTour(apiType: NetworkAPI, completion: @escaping (Result<[TourDTO], Error>) -> Void) {
        guard let urlRequest = apiType.url else {
               let error = NSError(domain: "YourDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
               completion(.failure(error))
               return
           }
        
        AF.request(urlRequest).responseData { response in
            switch response.result {
            case .success(let data):
                if let decodedResult: [TourDTO] = DecodeHelper.decodeDataToObject(data: data) {
                    completion(.success(decodedResult))
                } else {
                    let error = NSError(domain: "YourDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: "Decoding failed"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCategory(apiType: NetworkAPI, completion: @escaping (Result<[CategoryDTO], Error>) -> Void) {
        guard let urlRequest = apiType.url else {
            let error = NSError(domain: "YourDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        AF.request(urlRequest).responseData { response in
            switch response.result {
            case .success(let data):
                if let decodedResult: [CategoryDTO] = DecodeHelper.decodeDataToObject(data: data) {
                    completion(.success(decodedResult))
                } else {
                    let error = NSError(domain: "YourDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: "Decoding failed"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func addReservation(apiType: NetworkAPI, tourID: String, phoneNumber: String, reservationComment: String, numberOfPeople: Int, completion: @escaping (Result<String, Error>) -> Void) {
        guard let urlRequest = apiType.url else {
            let error = NSError(domain: "YourDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        let parameters: Parameters = [
            "tourID": tourID,
            "phoneNumber": phoneNumber,
            "reservationComment": reservationComment,
            "numberOfPeople": numberOfPeople
        ]
        
        AF.request(urlRequest, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                if let result = String(data: data, encoding: .utf8) {
                    completion(.success(result))
                } else {
                    let error = NSError(domain: "YourDomain", code: 500, userInfo: [NSLocalizedDescriptionKey: "Decoding failed"])
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

