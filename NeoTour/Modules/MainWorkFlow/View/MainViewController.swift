//
//  MainViewController.swift
//  NeoTour
//
//  Created by anjella on 15/2/24.
//

import UIKit

class MainViewController: UIViewController, ReuseIdentifying {

    private var viewModel: MainViewModel?
    
    private var toursCategoryData: [ToursCategoryModel] = [
    ToursCategoryModel(name: "Popular"), // Popular, Featured, Most Visited, Europe, Europe
    ToursCategoryModel(name: "Featured"),
    ToursCategoryModel(name: "Most Visited"),
    ToursCategoryModel(name: "Europe"),
    ToursCategoryModel(name: "Asia"),
    ToursCategoryModel(name: "Asia"),
    ToursCategoryModel(name: "Asia"),
    ]
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var discoverLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Discover"
        if let font = UIFont(name: "SF-Pro-Display-Black", size: 32) {
            label.font = font
        } else {
            label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        }
        return label
    }()
    
    private lazy var toursCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .red
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
}

extension MainViewController {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
        configureCollectionViews()
    }
    
    private func setUpSubviews() {
        view.addSubview(discoverLabel)
        view.addSubview(toursCategoryCollectionView)
    }
    
    private func setUpConstraints() {
        discoverLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(139)
            $0.height.equalTo(38)
        }
        
        toursCategoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(97)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(39)
        }
    }
    
    private func configureCollectionViews() {
        toursCategoryCollectionView.register(ToursCategoryCollectionViewCell.self, forCellWithReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier)
        toursCategoryCollectionView.dataSource = self
        toursCategoryCollectionView.delegate = self
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        toursCategoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = toursCategoryCollectionView.dequeueReusableCell(
            withReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ToursCategoryCollectionViewCell else { fatalError() }
        
        let toursData = toursCategoryData[indexPath.row]
        cell.displayInfo(tours: toursData)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = toursCategoryData[indexPath.item]
        let label = UILabel()
        label.text = category.name
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.sizeToFit()
        return CGSize(width: label.frame.width + 20, height: collectionView.bounds.height)
    }
}
