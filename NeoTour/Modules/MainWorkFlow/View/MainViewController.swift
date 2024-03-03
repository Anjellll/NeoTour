//
//  MainViewController.swift
//  NeoTour
//
//  Created by anjella on 20/2/24.
//

import UIKit

class MainViewController: UIViewController, ReuseIdentifying {
    
    static let sectionHeaderElementKind = "section-header-element-kin"
    private var viewModel: MainViewModel
    private var selectedIndexPath: IndexPath?
    
    enum Section: CaseIterable {
        case categoryTours
        case galeryTour
        case recommendedTours
    }
    
    enum Item: Hashable {
        case category(CategoryDTO)
        case galery(TourDTO)
        case recommended(TourDTO)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    private lazy var baseCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(
            ToursCategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            TourCollectionViewCell.self,
            forCellWithReuseIdentifier: TourCollectionViewCell.reuseIdentifier
        )
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind,
            withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(
            RecommendedToursCollectionCell.self,
            forCellWithReuseIdentifier: RecommendedToursCollectionCell.reuseIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.indicatorStyle = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
//    private lazy var mainCollectionView: MainCollectionView = {
//        let collectionView = MainCollectionView(frame: .zero)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.indicatorStyle = .black
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isUserInteractionEnabled = true
//        return collectionView
//    }()
    
    private var tour: [TourDTO] = []
    private var tourRecommended: [TourDTO] = []
    private var categories: [CategoryDTO] = []

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
        label.font = UIFont(name: "Avenir Next Bold", size: 32)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
        configureDataSource()
        setUpCollectionView()
        fetchTour()
        viewModel.fetchTour()
        fetchCategory()
        viewModel.fetchCategory()
        updateCollectionView()
    }
    
    private func fetchTour() {
        viewModel.reloadTourUI = { [weak self] in
            guard let self = self else { return }
            self.tour = self.viewModel.getTour()
            self.tourRecommended = self.viewModel.getTour()
            self.updateCollectionView()
        }
    }
    
    private func fetchCategory() {
        viewModel.reloadCategoryUI = { [weak self ] in
            guard let self = self else { return }
            self.categories = self.viewModel.getCategories()
            self.updateCollectionView()
        }
    }
    
    private func updateCollectionView() {
        DispatchQueue.main.async {
            self.baseCollectionView.performBatchUpdates({
                self.dataSource.apply(self.snapshot(), animatingDifferences: false)
            }, completion: nil)
        }
    }
    
    private func snapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.categoryTours, .galeryTour, .recommendedTours])
        snapshot.appendItems(categories.map { Item.category($0) }, toSection: .categoryTours)
        snapshot.appendItems(tour.map { Item.galery($0) }, toSection: .galeryTour)
        snapshot.appendItems(tourRecommended.map { Item.recommended($0) }, toSection: .recommendedTours)
        return snapshot
    }
    
    private func setUpCollectionView() {
        baseCollectionView.delegate = self
        baseCollectionView.dataSource = dataSource
    }
}

extension MainViewController {
    private func setUpUI() {
        view.addSubview(discoverLabel)
        discoverLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(139)
            $0.height.equalTo(38)
        }
        
        view.addSubview(baseCollectionView)
        baseCollectionView.snp.makeConstraints {
            $0.top.equalTo(discoverLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension MainViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: baseCollectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .category(let data):
                return self.configureCategoryCell(collectionView: collectionView, indexPath: indexPath, data: data)
            case .galery(let data):
                return self.configureGaleryCell(collectionView: collectionView, indexPath: indexPath, data: data)
            case .recommended(let data):
                return self.configureRecommendedCell(collectionView: collectionView, indexPath: indexPath, data: data)
            }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return self.configureHeaderView(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
    }

    private func configureCategoryCell(collectionView: UICollectionView, indexPath: IndexPath, data: CategoryDTO) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? ToursCategoryCollectionViewCell else {
            fatalError("Failed to dequeue a cell of type ToursCategoryCollectionViewCell")
        }
        cell.displayInfo(tours: data)
        return cell
    }

    private func configureGaleryCell(collectionView: UICollectionView, indexPath: IndexPath, data: TourDTO) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TourCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! TourCollectionViewCell
        cell.configure(tour: data)
        return cell
    }

    private func configureRecommendedCell(collectionView: UICollectionView, indexPath: IndexPath, data: TourDTO) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecommendedToursCollectionCell.reuseIdentifier,
            for: indexPath
        ) as! RecommendedToursCollectionCell
        cell.setUpRecommendedView(tour: data)
        return cell
    }

    private func configureHeaderView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.reuseIdentifier,
            for: indexPath
        ) as? HeaderView else {
            fatalError("Cannot create header view")
        }
        supplementaryView.label.text = "Recommended"
        return supplementaryView
    }
}

extension MainViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,                                layoutEnvironment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch (sectionLayoutKind) {
            case .categoryTours:
                return self.generateCategoryLayout(isWide: isWideView)
            case .galeryTour:
                return self.generateToursLayout(isWide: isWideView)
            case .recommendedTours:
                return self.generateRecommendedTourLayout()
            }
        }
        return layout
    }
    
    private func generateCategoryLayout(isWide: Bool) -> NSCollectionLayoutSection {
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
            elementKind: MainViewController.sectionHeaderElementKind,
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
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = Section.allCases[indexPath.section]
        let item = dataSource.itemIdentifier(for: indexPath)
        
        switch section {
        case .categoryTours:
            if case .category(let data) = item {
                if let cell = collectionView.cellForItem(at: indexPath) as? ToursCategoryCollectionViewCell {
                    cell.categoryLabel.font = UIFont(name: "Avenir Next Bold", size: 16)
                    cell.categoryLabel.textColor = UIColor(red: 106/255,
                                                           green: 98/255,
                                                           blue: 183/255,
                                                           alpha: 1)
                    updateCollectionViewForCategory(data)
                    cell.selectedPoint.isHidden = false
                }
            }
        case .galeryTour:
            if case let .galery(data) = item {
                let detailViewModel = DetailViewModel()
                let detailViewController = DetailViewController(viewModel: detailViewModel)
                detailViewController.tour = data
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        case .recommendedTours:
            if case let .recommended(data) = item {
                let detailViewModel = DetailViewModel()
                let detailViewController = DetailViewController(viewModel: detailViewModel)
                detailViewController.tour = data
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
    private func updateCollectionViewForCategory(_ category: CategoryDTO) {
        let toursForCategory = category.tours ?? []
        
        tour = toursForCategory
        updateCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard Section.allCases[indexPath.section] == .categoryTours else {
            return
        }
        
        let item = dataSource.itemIdentifier(for: indexPath)
        
        if case .category(_) = item {
            if let cell = collectionView.cellForItem(at: indexPath) as? ToursCategoryCollectionViewCell {
                cell.categoryLabel.font = UIFont(name: "Avenir Next", size: 16)
                cell.categoryLabel.textColor = .black
                
                cell.selectedPoint.isHidden = true
                cell.sizeToFit()
            }
        }
    }
}






