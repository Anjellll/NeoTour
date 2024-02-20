//
//  TestingMainViewController.swift
//  NeoTour
//
//  Created by anjella on 20/2/24.
//

import UIKit

class TestingMainViewController: UIViewController, ReuseIdentifying {
    
    static let sectionHeaderElementKind = "section-header-element-kin"
    private var viewModel: TestingMainViewModel
    
    enum Section: CaseIterable {
        case categoryTours
        case galeryTour
        case recommendedTours
    }
    
    enum Item: Hashable {
        case category(ToursCategoryModel)
        case galery(TourModel)
        case recommended(TourModel)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    private lazy var mainViewCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(
            ToursCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            TourCollectionViewCell.self,
            forCellWithReuseIdentifier: TourCollectionViewCell.reuseIdentifier
        )
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: TestingMainViewController.sectionHeaderElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(
            RecommendedToursCollectionCell.self,
            forCellWithReuseIdentifier: RecommendedToursCollectionCell.reuseIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.indicatorStyle = .black
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var toursCategoryData: [ToursCategoryModel] = [
    ToursCategoryModel(name: "Popular"),
    ToursCategoryModel(name: "Featured"),
    ToursCategoryModel(name: "Most Visited"),
    ToursCategoryModel(name: "Europe"),
    ToursCategoryModel(name: "Asia"),
    ToursCategoryModel(name: "Asia")
    ]
    
    private var toursData: [TourModel] = [
    TourModel(name: "Northern Mountain", image: "placeImage1"),
    TourModel(name: "Mount Fuji", image: "placeImage2"),
    TourModel(name: "Northern Mountain", image: "placeImage1"),
    TourModel(name: "Mount Fuji", image: "placeImage2")
    ]
    
    init(viewModel: TestingMainViewModel) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
        configureDataSource()
    }
}

extension TestingMainViewController {
    func createLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,                                layoutEnvironment: NSCollectionLayoutEnvironment)
        -> NSCollectionLayoutSection? in
        let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
        
        let sectionLayoutKind = Section.allCases[sectionIndex]
        switch (sectionLayoutKind) {
        case .categoryTours:
            return self.generateCarouselLayout(isWide: isWideView)
        case .galeryTour:
            return self.generateToursLayout(isWide: isWideView)
        case .recommendedTours:
            return self.generateRecommendedTourLayout()
        }
      }
      return layout
    }
    
    private func generateCarouselLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupFractionalWidth = isWide ? 0.475 : 0.95
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
          heightDimension: .absolute(CGFloat(50)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(
          top: 5,
          leading: 5,
          bottom: 5,
          trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func generateRecommendedTourLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: TestingMainViewController.sectionHeaderElementKind,
          alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        
        return section
    }
    
    private func generateToursLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth = isWide ? 0.475 : 0.95
        let groupFractionalHeight: Float = isWide ? 1/3 : 2/3
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
      
        return section
    }

    
    private func setUpUI() {
        view.addSubview(discoverLabel)
        discoverLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(139)
            $0.height.equalTo(38)
        }
        
        view.addSubview(mainViewCollectionView)
        mainViewCollectionView.snp.makeConstraints {
            $0.top.equalTo(discoverLabel.snp.bottom).offset(11)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: mainViewCollectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in

            let sectionType = Section.allCases[indexPath.section]
            switch sectionType {
            case .categoryTours:
                guard case let .category(data) = item else {
                                fatalError("Invalid item type for carouselTour section")
                            }
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? ToursCategoryCollectionViewCell else {
                    fatalError("Failed to dequeue a cell of type CarouselCollectionViewCell")
                }
                cell.displayInfo(tours: data)
                return cell
            case .galeryTour:
                guard case let .galery(data) = item else {
                                fatalError("Invalid item type for carouselTour section")
                            }
                let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: TourCollectionViewCell.reuseIdentifier,
                  for: indexPath
                ) as! TourCollectionViewCell
                cell.configure(tour: data)
                return cell
            case .recommendedTours:
                guard case let .recommended(data) = item else {
                                fatalError("Invalid item type for carouselTour section")
                            }
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RecommendedToursCollectionCell.reuseIdentifier,
                    for: indexPath
                ) as! RecommendedToursCollectionCell
                cell.setUpRecommendedView(tour: data)
                return cell
            }
            
        })
        dataSource.supplementaryViewProvider = { (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath)
          -> UICollectionReusableView? in
          
          guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.reuseIdentifier,
            for: indexPath) as? HeaderView else {
            fatalError("Cannot create header view")
          }
          
          supplementaryView.label.text = "Recommended"
          return supplementaryView
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.categoryTours, .galeryTour, .recommendedTours])
        
        let carouselItems =  toursCategoryData
        snapshot.appendItems(carouselItems.map { Item.category($0) }, toSection: .categoryTours)

        let galeryItems: [TourModel] = toursData
        snapshot.appendItems(galeryItems.map { Item.galery($0) }, toSection: .galeryTour)

        let recommendedItems: [TourModel] = toursData
        snapshot.appendItems(recommendedItems.map { Item.recommended($0) }, toSection: .recommendedTours)

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension TestingMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        let item = dataSource.itemIdentifier(for: indexPath)
        
        switch section {
        case .categoryTours:
            if case let .category(_) = item {
                if let cell = collectionView.cellForItem(at: indexPath) as? ToursCategoryCollectionViewCell {
                    cell.categoryLabel.font = UIFont(name: "Avenir Next Bold", size: 16)
                    cell.categoryLabel.textColor = .red
                    cell.selectedPoint.isHidden = false
                }
            }
        case .galeryTour:
            if case let .galery(data) = item {
               
            }
        case .recommendedTours:
            if case let .recommended(data) = item {
            
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if Section.allCases[indexPath.section] == .categoryTours {
            let item = dataSource.itemIdentifier(for: indexPath)
            if case let .category(_) = item {
                if let cell = collectionView.cellForItem(at: indexPath) as? ToursCategoryCollectionViewCell {
                    cell.categoryLabel.font = UIFont(name: "Avenir Next", size: 16)
                    cell.categoryLabel.textColor = .black
                    cell.selectedPoint.isHidden = true
                    
                }
            }
        }
    }
}

