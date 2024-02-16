//
//  ToursCategoryCollectionViewCell.swift
//  NeoTour
//
//  Created by anjella on 15/2/24.
//

import UIKit

class ToursCategoryCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    private lazy var categoryLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.black
        label.textAlignment = .center
//        label.backgroundColor = .brown
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
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
    }
    
    private func setUpConstraints() {
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(39)
        }
    }
    
    func displayInfo(tours: ToursCategoryModel) {
        categoryLabel.text = tours.name
    }
}
