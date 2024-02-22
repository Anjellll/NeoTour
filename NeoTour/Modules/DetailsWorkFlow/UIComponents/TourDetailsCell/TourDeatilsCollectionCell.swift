//
//  TourDetilsCollectionCell.swift
//  NeoTour
//
//  Created by anjella on 21/2/24.
//

import UIKit

class TourDetilsCollectionCell: UICollectionViewCell, ReuseIdentifying {
    
    private var tour: TourModel?
    
    private var reviewData: [ReviewsModel] = [
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous", userReview: "Good good good good good Good good good good goodGood good good good good Good good good good good Good good good good good Good good good good good Good good good good good Good good good good good"),
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous2", userReview: "Good good good good good Good good good good good Good good good good good"),
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous3", userReview: "Good good good good good Good good good good goodGood good good good good Good good good good good Good good good good good Good good good good good Good good good good good Good good good good good")
    ]
    
    private lazy var placeImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        if let imageName = tour?.image {
            image.image = UIImage(named: imageName)
        } else {
            image.image = UIImage(named: "placeImage2")
        }
        return image
    }()
    
    private lazy var placeNameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.textColor = UIColor.black
        label.text = tour?.name ?? "Bishkek"
        label.backgroundColor = .purple
        return label
    }()
    
    private lazy var placeLocationLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.white
        label.text = "New York"
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var placeLocationIcon: UIImageView = {
        var image = UIImageView()
        image.contentMode = .center
        image.image = UIImage(named: "locationIcon")
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.white
        label.text = "Description"
        label.backgroundColor = .orange
        return label
    }()
    
    private lazy var descriptionTourLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text =
        """
        kmlmfvklvmfrkl klmvlrkmflkr lkrfmlk
        kmfrk jjjjj kkkkk llll krefmr fff
        kmfr  mmm mmm ooo lkmf fffff
        pppp llll kkk ffff rrrr tttt eee ddd
        """
        label.backgroundColor = .gray
        return label
    }()
    
    private lazy var reviewsLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor.black
        label.text = "Reviews"
        label.backgroundColor = .cyan
        return label
    }()
    
    let verticelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .green
        return stack
    }()
    
    lazy var contentViewTesting: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .yellow
        circleView.layer.cornerRadius = 410 / 10
        return circleView
    }()
    
    lazy var baseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        collectionView.backgroundColor = .green
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollectionView() {
        baseCollectionView.register(TourDetailsCell.self, forCellWithReuseIdentifier: TourDetailsCell.reuseIdentifier)
        baseCollectionView.delegate = self
        baseCollectionView.dataSource = self
    }
}

extension TourDetilsCollectionCell {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(baseCollectionView)
        addSubview(verticelStack)
        
      
        addSubview(placeNameLabel)
        placeImage.addSubview(contentViewTesting)
        verticelStack.addArrangedSubview(placeImage)
//        addSubview(contentViewTesting)
//        placeImage.addSubview(contentViewTesting)
        
        addSubview(placeLocationLabel)
        addSubview(placeLocationIcon)
        addSubview(descriptionLabel)
        addSubview(descriptionTourLabel)
        addSubview(reviewsLabel)
    }
    
    private func setUpConstraints() {
        
        verticelStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
//            make.bottom.equalToSuperview().inset(24)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(500)
            make.width.equalTo(410)
        }
        
        baseCollectionView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
        }

        placeImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(100)
        }
        
        placeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(420)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(123)
            make.height.equalTo(29)
        }
    
        contentViewTesting.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(390)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(400)
        }

        placeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(12)
            make.leading.equalTo(placeLocationIcon.snp.trailing).offset(8)
            make.height.equalTo(14)
            make.width.equalTo(78)
        }
        
        placeLocationIcon.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(12)
            make.height.width.equalTo(14)
            make.leading.equalToSuperview().offset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(placeLocationLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(24)
            make.width.equalTo(120)
        }
        
        descriptionTourLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(92)
            make.width.equalTo(385)
        }
        
        reviewsLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTourLabel.snp.bottom).offset(30)
            make.height.equalTo(24)
            make.width.equalTo(1002)
            make.leading.equalToSuperview().offset(16)
        }
        
        verticelStack.setCustomSpacing(15, after: placeImage)
    }
}

extension TourDetilsCollectionCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourDetailsCell.reuseIdentifier, for: indexPath) as! TourDetailsCell
        let review = reviewData[indexPath.row]
        cell.configure(data: review)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 386, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
