//
//  CategoryDTO.swift
//  NeoTour
//
//  Created by anjella on 25/2/24.
//

import Foundation

// MARK: - CategoryDTO
struct CategoryDTO: Codable, Hashable {
    let categoryID, categoryName: String?
    let tours: [TourDTO]?

    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: CategoryDTO, rhs: CategoryDTO) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName, tours
    }
}

