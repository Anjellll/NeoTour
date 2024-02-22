//
//  TestingCell.swift
//  NeoTour
//
//  Created by anjella on 22/2/24.
//

import UIKit

class TestingCell: UICollectionViewCell, ReuseIdentifying {
    
    var dataReview: ReviewsModel? {
        didSet {
            if let image = UIImage(named: dataReview?.userIcon ?? "defaultImage") {
                userIcon.image = image
            } else {
                userIcon.image = UIImage(named: "defaultImage")
            }
            userNameLabel.text = dataReview?.userName
            userReview.text = dataReview?.userReview
        }
    }
    
    private lazy var userIcon: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.clipsToBounds = true
        image.image = UIImage(named: "userIcon")
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.white
        label.text = "Anonymous"
        label.backgroundColor = .red
        return label
    }()
    
    private lazy var userReview: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.white
        label.text = "Good good good good good111 Good good good good good Good good good good good "
        label.backgroundColor = .blue
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .systemPink
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TestingCell {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(userIcon)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(userReview)
    }
    
    private func setUpConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(385)
            $0.height.equalTo(150)
        }
        
        userIcon.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.left.equalTo(userIcon.snp.right).offset(8)
            $0.width.equalTo(84)
            $0.height.equalTo(19)
        }
        
        userReview.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).inset(15)
            $0.left.equalToSuperview().offset(16)
            $0.width.equalTo(385)
            $0.height.equalTo(90)
        }
    }
}

