//
//  TestingDetailViewController.swift
//  NeoTour
//
//  Created by anjella on 22/2/24.
//

import UIKit

class TestingDetailViewController: UIViewController {

    private var viewModel: TestingDetailViewModel
    weak var coordinator: AppCoordinator?
    private var tour: TourModel?
    
    private var reviewData: [ReviewsModel] = [
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous", userReview: "Good good good good good Good good good good goodGood good good good good Good good good good good Good good good good good Good good good good good Good good good good good Good good good good good"),
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous2", userReview: "Good good good good good Good good good good good Good good good good good"),
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous3", userReview: "Good good good good good Good good good good goodGood good good good good Good good good good good Good good good good good Good good good good good Good good good good good Good good good good good")
    ]
    
    init(viewModel: TestingDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
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
        return label
    }()
    
    private lazy var placeLocationLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.black
        label.text = "New York"
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
        label.textColor = UIColor.black
        label.text = "Description"
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
        kmlmfvklvmfrkl klmvlrkmflkr lkrfmlk jhkjb  fre f
        kmfrk jjjjj kkkkk llll krefmr fffn  fre fr rfe
        kmfr  mmm mmm ooo lkmf fffff  ref  fre f  f re
        pppp llll kkk ffff rrrr tttt eee ddd fref  ferf
        """
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
    
    lazy var contentViewTesting: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.cornerRadius = 410 / 10
//        circleView.backgroundColor = .red
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpCollectionView()
        view.backgroundColor = .white
    }
    
    func setUpCollectionView() {
        baseCollectionView.register(TourDetailsCell.self, forCellWithReuseIdentifier: TourDetailsCell.reuseIdentifier)
        baseCollectionView.delegate = self
        baseCollectionView.dataSource = self
    }
}

extension TestingDetailViewController {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(baseCollectionView)
//        addSubview(verticelStack)
        
      
       
        placeImage.addSubview(contentViewTesting)
        view.addSubview(placeNameLabel)
        view.addSubview(placeImage)
//        addSubview(contentViewTesting)
//        placeImage.addSubview(contentViewTesting)
        
        view.addSubview(placeLocationLabel)
        view.addSubview(placeLocationIcon)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTourLabel)
        view.addSubview(reviewsLabel)
    }
    
    private func setUpConstraints() {
        baseCollectionView.snp.makeConstraints { maker in
            maker.top.equalTo(reviewsLabel.snp.bottom).offset(3)
            maker.leading.trailing.bottom.equalToSuperview()
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
            make.width.equalTo(123)
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
        
//        verticelStack.setCustomSpacing(15, after: placeImage)
    }
}

extension TestingDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
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
        CGSize(width: 386, height: 120)
    }
}
