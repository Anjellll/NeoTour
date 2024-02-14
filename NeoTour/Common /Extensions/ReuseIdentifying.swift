//
//  ReuseIdentifying.swift
//  NeoTour
//
//  Created by anjella on 14/2/24.
//

import Foundation

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

