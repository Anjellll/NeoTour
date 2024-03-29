//
//  ToursCategoryCollectionViewCell.swift
//  NeoTour
//
//  Created by anjella on 15/2/24.
//

import UIKit

class ToursCategoryCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    var tourCategory: CategoryDTO?
    
    lazy var categoryLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var selectedPoint: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = UIColor(red: 106/255,
                                             green: 98/255,
                                             blue: 183/255,
                                             alpha: 1)
        circleView.layer.cornerRadius = 3.5
        circleView.isHidden = true
        return circleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func displayInfo(tours: CategoryDTO) {
        self.tourCategory = tours
        
        if let name = tours.categoryName {
            categoryLabel.text = name
        } else {
            categoryLabel.text = "N/A"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ToursCategoryCollectionViewCell {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(categoryLabel)
        addSubview(selectedPoint)
    }
    
    private func setUpConstraints() {
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(35)
        }
        
        selectedPoint.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.top.equalTo(categoryLabel.snp.bottom)
            $0.width.equalTo(7)
            $0.height.equalTo(7)
        }
    }
}
