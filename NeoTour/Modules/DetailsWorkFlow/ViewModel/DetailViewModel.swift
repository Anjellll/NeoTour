//
//  DetailViewModel.swift
//  NeoTour
//
//  Created by anjella on 22/2/24.
//

import Foundation

protocol DetailViewDelegate: NSObject {
    func updateUI()
}

class DetailViewModel {
    
    weak var delegate: DetailViewDelegate?
    
    init(tour: TourDTO?) {
        self.tour = tour
    }
    
    var tour: TourDTO? {
        didSet {
            delegate?.updateUI()
        }
    }
    
    private var reviewData: [ReviewsModel] = ReviewsModel.getReviews()

    func getReviewCount() -> Int {
        reviewData.count
    }
    
    func getReview(index: Int) -> ReviewsModel {
        reviewData[index]
    }
}
