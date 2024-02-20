//
//  ToursCategoryModel.swift
//  NeoTour
//
//  Created by anjella on 15/2/24.
//

import Foundation

struct ToursCategoryModel: Hashable {
    let name: String
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: ToursCategoryModel, rhs: ToursCategoryModel) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
}
