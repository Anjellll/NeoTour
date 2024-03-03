//
//  DecodeHelper.swift
//  NeoTour
//
//  Created by anjella on 27/2/24.
//

import Foundation

final class DecodeHelper {
    static func decodeDataToObject<T: Codable>(data: Data?) -> T? {
        if let data = data {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("Decoding failed: \(error)")
            }
        }
        return nil
    }
}
