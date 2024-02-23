//
//  TourDetailsCell.swift
//  NeoTour
//
//  Created by anjella on 21/2/24.
//

import UIKit

class TourDetailsCell: UICollectionViewCell, ReuseIdentifying {
    
    private lazy var userIcon: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 24 / 2
        image.clipsToBounds = true
        image.image = UIImage(named: "userIcon")
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = UIColor.black
        label.text = "Anonymous"
        return label
    }()
    
    private lazy var userReview: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = UIColor.black
        label.text = "Good good good good good111 Good good good good good Good good good good good "
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    lazy var contentViewTesting: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
//        circleView.layer.cornerRadius = 410 / 10
//        circleView.backgroundColor = .red
        return circleView
    }()
    
    func configure(data: ReviewsModel) {
        if let image = UIImage(named: data.userIcon) {
            userIcon.image = image
        } else {
            userIcon.image = UIImage(named: "defaultImage")
        }
        userNameLabel.text = data.userName
        userReview.text = data.userReview
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TourDetailsCell {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(contentViewTesting)
        contentViewTesting.addSubview(userIcon)
        contentViewTesting.addSubview(userNameLabel)
        contentViewTesting.addSubview(userReview)
    }
    
    private func setUpConstraints() {   // здесь надо менять!!!
        contentViewTesting.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(385)
            $0.height.equalTo(120)
        }
        
        userIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.left.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.left.equalTo(userIcon.snp.right).offset(8)
            $0.width.equalTo(100)
            $0.height.equalTo(19)
        }
        
        userReview.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(385)
            $0.height.equalTo(90)
        }
    }
}

