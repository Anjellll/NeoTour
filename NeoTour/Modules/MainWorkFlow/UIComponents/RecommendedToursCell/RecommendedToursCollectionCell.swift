//
//  RecommendedToursCollectionCell.swift
//  NeoTour
//
//  Created by anjella on 17/2/24.
//

import UIKit

class RecommendedToursCollectionCell: UICollectionViewCell, ReuseIdentifying {
 
    private lazy var placeNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.white
        return label
    }()
    
    private lazy var placeImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpRecommendedView(tour: TourDTO) {
        placeNameLabel.text = tour.tourName
        
        
        if let tourImageURL = tour.imageURL,
           let imageURL = URL(string: tourImageURL) {
            placeImage.kf.setImage(with: imageURL, placeholder: UIImage(named: "defaultImage"))
        } else {
            placeImage.image = UIImage(named: "defaultImage")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommendedToursCollectionCell {
    private func setUpUI() {
        setUpSubviews()
        setupConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(placeImage)
        placeImage.addSubview(placeNameLabel)
    }
    
    private func setupConstraints() {
        placeImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
            $0.height.equalTo(24)
            $0.width.equalTo(180)
        }
    }
}

