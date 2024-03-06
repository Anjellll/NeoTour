//
//  DetailView.swift
//  NeoTour
//
//  Created by anjella on 5/3/24.
//

import UIKit

class DetailView: UIView {
    
    private lazy var placeImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var placeNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var placeLocationLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 12)
        label.textColor = UIColor.black
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
        label.font = UIFont(name: "Avenir Next Bold", size: 20)
        label.textColor = UIColor.black
        label.text = "Description"
        return label
    }()
    
    private lazy var descriptionTourLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private lazy var reviewsLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 20)
        label.textColor = UIColor.black
        label.text = "Reviews"
        return label
    }()
    
    lazy var contentViewTesting: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = 410 / 10
        circleView.backgroundColor = .white
        return circleView
    }()
    
    lazy var bookNowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Book Now", for: .normal)
        button.backgroundColor = UIColor(red: 106/255,
                                         green: 98/255,
                                         blue: 183/255,
                                         alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var baseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        collectionView.register(TourDetailsCell.self, forCellWithReuseIdentifier: TourDetailsCell.reuseIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setup()
    }
    
    func updateView(tour: TourDTO?) {
        placeNameLabel.text = tour?.tourName ?? "Default Name"
        placeLocationLabel.text = tour?.tourLocation
        descriptionTourLabel.text = tour?.tourDescription
        if let tourImageURL = tour?.imageURL,
           let imageURL = URL(string: tourImageURL) {
            placeImage.kf.setImage(with: imageURL, placeholder: UIImage(named: "defaultImage"))
        } else {
            placeImage.image = UIImage(named: "defaultImage")
        }
    }
    
    private func setup() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(baseCollectionView)
        addSubview(bookNowButton)
        placeImage.addSubview(contentViewTesting)
        addSubview(placeNameLabel)
        addSubview(placeImage)
        addSubview(placeLocationLabel)
        addSubview(placeLocationIcon)
        addSubview(descriptionLabel)
        addSubview(descriptionTourLabel)
        addSubview(reviewsLabel)
    }
    
    private func setUpConstraints() {
        baseCollectionView.snp.makeConstraints { maker in
            maker.top.equalTo(reviewsLabel.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
        }
        
        bookNowButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.width.equalTo(385)
        }

        placeImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(389)
        }
        
        placeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(385)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(280)
            make.height.equalTo(29)
        }
    
        contentViewTesting.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(357)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(400)
        }

        placeLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(placeLocationIcon.snp.trailing).offset(8)
            make.height.equalTo(14)
            make.width.equalTo(78)
        }
        
        placeLocationIcon.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(8)
            make.height.width.equalTo(14)
            make.leading.equalToSuperview().offset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(placeLocationLabel.snp.bottom).offset(25)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
