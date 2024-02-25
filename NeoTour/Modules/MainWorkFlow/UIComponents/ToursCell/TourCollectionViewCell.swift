//
//  TourCollectionViewCell.swift
//  NeoTour
//
//  Created by anjella on 16/2/24.
//

import UIKit
import Kingfisher

class TourCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    var coordinator: AppCoordinator?
    
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
        self.isUserInteractionEnabled = true
    }
    
    func configure(tour: TourDTO) {
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
            $0.height.width.equalTo(185)  // ?
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.height.equalTo(17)
            $0.width.equalTo(200)
        }
    }
}

