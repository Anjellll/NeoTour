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
        if let url = apiType.components.url {
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        
                        let product = try JSONDecoder().decode(CategoryDTO.self, from: data)
                        if let data = product.tours {
                            completion(.success(data))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            let error = NSError(domain: "YourDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL is nil"])
            completion(.failure(error))
        }
    }
    
    func fetchCategory(apiType: NetworkAPI, completion: @escaping (Result<[CategoryDTO], Error>) -> Void) {
        if let url = apiType.components.url {
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let product = try JSONDecoder().decode([CategoryDTO].self, from: data)
                        completion(.success(product))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            let error = NSError(domain: "YourDomain", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL is nil"])
            completion(.failure(error))
        }
    }
}
