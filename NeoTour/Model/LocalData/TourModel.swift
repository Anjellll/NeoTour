//
//  TourModel.swift
//  NeoTour
//
//  Created by anjella on 16/2/24.
//

import Foundation

struct TourModel: Hashable {
    let name: String
    let image: String?
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: TourModel, rhs: TourModel) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
}


