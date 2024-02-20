//
//  ToursCategoryCollectionViewCell.swift
//  NeoTour
//
//  Created by anjella on 15/2/24.
//

import UIKit

class ToursCategoryCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    lazy var categoryLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .yellow
        return label
    }()
    
    lazy var selectedPoint: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .red
        circleView.layer.cornerRadius = 3.5
        circleView.isHidden = true
        return circleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func displayInfo(tours: ToursCategoryModel) {
        categoryLabel.text = tours.name
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
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
        
        selectedPoint.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(categoryLabel.snp.bottom).offset(5)
            make.width.equalTo(7)
            make.height.equalTo(7)
        }
    }
}
