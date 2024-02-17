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
    
    private var toursData: [TourModel] = [
    TourModel(name: "Northern Mountain", image: "placeImage1"),
    TourModel(name: "Mount Fuji", image: "placeImage2"),
    TourModel(name: "Northern Mountain", image: "placeImage1"),
    TourModel(name: "Mount Fuji", image: "placeImage2"),
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
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var  toursCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(
            red: CGFloat(0x6A) / 255.0,
            green: CGFloat(0x62) / 255.0,
            blue: CGFloat(0xB7) / 255.0,
            alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor(
            red: CGFloat(0xD0) / 255.0,
            green: CGFloat(0xCB) / 255.0,
            blue: CGFloat(0xFF) / 255.0,
            alpha: 1.0)
        pageControl.numberOfPages = toursData.count
        return pageControl
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
        view.addSubview(toursCollectionView)
        view.addSubview(pageControl)
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
        
        toursCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(167)
            $0.height.equalTo(254)
            $0.leading.trailing.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(toursCollectionView.snp.bottom)
            $0.height.equalTo(23)
        }
    }
    
    private func configureCollectionViews() {
        toursCategoryCollectionView.register(ToursCategoryCollectionViewCell.self, forCellWithReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier)
        toursCategoryCollectionView.dataSource = self
        toursCategoryCollectionView.delegate = self
        
        toursCollectionView.register(TourCollectionViewCell.self, forCellWithReuseIdentifier: TourCollectionViewCell.reuseIdentifier)
        
        toursCollectionView.dataSource = self
        toursCollectionView.delegate = self
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == toursCategoryCollectionView {
            return toursCategoryData.count
        } else if collectionView == toursCollectionView {
            return toursData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == toursCategoryCollectionView {
            guard let cell = toursCategoryCollectionView.dequeueReusableCell(
                withReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ToursCategoryCollectionViewCell else { fatalError() }
            
            let toursData = toursCategoryData[indexPath.row]
            cell.displayInfo(tours: toursData)
            return cell
        } else if  collectionView == toursCollectionView {
            guard let cell = toursCollectionView.dequeueReusableCell(
                withReuseIdentifier: TourCollectionViewCell.reuseIdentifier,
                for: indexPath) as? TourCollectionViewCell else { fatalError() }
            let tour = toursData[indexPath.item]
            cell.displayInfo(tour: tour)
            return cell
        }
        fatalError("Unexpected collection view")
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        pageControl.currentPage = currentPage
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == toursCategoryCollectionView {
            let category = toursCategoryData[indexPath.item]
            let label = UILabel()
            label.text = category.name
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: collectionView.bounds.height)
        } else if collectionView == toursCollectionView {
            return CGSize(width: 335, height: 254)
        }
        return CGSize.zero
    }
}
