//
//  ListItem.swift
//  NeoTour
//
//  Created by anjella on 7/3/24.
//

import Foundation

enum Item: Hashable {
    case category(CategoryDTO)
    case galery(TourDTO)
    case recommended(TourDTO)
}
