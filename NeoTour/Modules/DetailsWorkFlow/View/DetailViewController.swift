//
//  DetailViewController.swift
//  NeoTour
//
//  Created by anjella on 22/2/24.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: DetailViewModel
    var tour: TourDTO? {
        didSet {
            updateUI()
        }
    }
    
    private var reviewData: [ReviewsModel] = ReviewsModel.getReviews()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
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
        button.addTarget(self, action: #selector(bookNowButtonTapped), for: .touchUpInside)
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
        return collectionView
    }()
    
    private func updateUI() {
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
    
    @objc func bookNowButtonTapped() {
        let viewModel = PopUpInformationViewModel()
        let viewController = PopUpInformationViewController(viewModel: viewModel)
        viewController.tour = tour
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(viewController, animated: true, completion: nil)
        }
    }
}

extension DetailViewController {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(baseCollectionView)
        view.addSubview(bookNowButton)
        placeImage.addSubview(contentViewTesting)
        view.addSubview(placeNameLabel)
        view.addSubview(placeImage)
        view.addSubview(placeLocationLabel)
        view.addSubview(placeLocationIcon)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTourLabel)
        view.addSubview(reviewsLabel)
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
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
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



   
