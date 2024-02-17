//
//  TourCollectionViewCell.swift
//  NeoTour
//
//  Created by anjella on 16/2/24.
//

import UIKit

class TourCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    private lazy var placeNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var placeImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.backgroundColor = .gray
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TourCollectionViewCell {
    private func setUpUI() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(placeImage)
        placeImage.addSubview(placeNameLabel)
    }
    
    private func setupConstraints() {
        placeImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.height.equalTo(24)
            $0.width.equalTo(180)
        }
    }
    
    func displayInfo(tour: TourModel) {
        placeNameLabel.text = tour.name
        
        if let image = tour.image {
            placeImage.image = UIImage(named: image)
        } else {
            placeImage.image = UIImage(named: "placeholderImage")
        }
    }
}

