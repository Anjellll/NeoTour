//
//  MainViewModel .swift
//  NeoTour
//
//  Created by anjella on 20/2/24.
//

import Foundation
import Alamofire

protocol MainViewModelType {
    var reloadTourUI: (() -> Void)? { get set }
    var reloadCategoryUI: (() -> Void)? { get set }
    func fetchTour()
    func fetchCategory()
}

class MainViewModel: MainViewModelType {
    
    var reloadTourUI: (() -> Void)?
    var reloadCategoryUI: (() -> Void)?
    
    var tourCategories: [CategoryDTO] = []
    private var tours: [TourDTO] = []
    
    
    private let networkLayer = NetworkLayer.shared
    
    func fetchTour() {
        networkLayer.fetchTour(apiType: .getTourList) { [weak self] result in
            switch result {
            case .success(let tours):
                self?.tours = tours
                self?.reloadTourUI?()
            case .failure(let error):
                print("Ошибка при загрузке туров: \(error)")
            }
        }
    }
    
    func fetchCategory() {
        networkLayer.fetchCategory(apiType: .getTourCategoryList) { [weak self] result in
            switch result {
            case .success(let tourCategories):
                self?.tourCategories = tourCategories
                self?.reloadCategoryUI?()
            case .failure(let error):
                print("Ошибка при загрузке категорий: \(error)")
            }
        }
    }
    
    
    func getTour() -> [TourDTO] {
        return tours
    }
    
    func getCategories() -> [CategoryDTO] {
        return tourCategories
    }

}
