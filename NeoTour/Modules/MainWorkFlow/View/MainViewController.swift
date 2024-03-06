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
    
    lazy var contentView = MainView()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = contentView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        configureDataSource()
        setUpCollectionView()
        fetchTour()
        viewModel.fetchTour()
        fetchCategory()
        viewModel.fetchCategory()
        updateCollectionView()
    }
}

extension MainViewController {
    private func fetchTour() {
        viewModel.reloadTourUI = { [weak self] in
            guard let self = self else { return }
            self.viewModel.tours = self.viewModel.tours
            self.viewModel.tourRecommended = self.viewModel.tourRecommended
            self.updateCollectionView()
        }
    }
    
    private func fetchCategory() {
        viewModel.reloadCategoryUI = { [weak self ] in
            guard let self = self else { return }
            self.viewModel.tourCategories = self.viewModel.tourCategories
            self.updateCollectionView()
        }
    }
    
    private func updateCollectionView() {
        DispatchQueue.main.async {
            self.contentView.baseCollectionView.performBatchUpdates({
                self.dataSource.apply(self.snapshot(), animatingDifferences: false)
            }, completion: nil)
        }
    }
    
    private func snapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.categoryTours, .galeryTour, .recommendedTours])
        snapshot.appendItems(viewModel.tourCategories.map { Item.category($0) }, toSection: .categoryTours)
        snapshot.appendItems(viewModel.tours.map { Item.galery($0) }, toSection: .galeryTour)
        snapshot.appendItems(viewModel.tourRecommended.map { Item.recommended($0) }, toSection: .recommendedTours)
        return snapshot
    }
    
    private func setUpCollectionView() {
        contentView.baseCollectionView.delegate = self
        contentView.baseCollectionView.dataSource = dataSource
    }
}

extension MainViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: contentView.baseCollectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
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
                let detailViewModel = DetailViewModel(tour: data)
                let detailViewController = DetailViewController(viewModel: detailViewModel)
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        case .recommendedTours:
            if case let .recommended(data) = item {
                let detailViewModel = DetailViewModel(tour: data)
                let detailViewController = DetailViewController(viewModel: detailViewModel)
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
    private func updateCollectionViewForCategory(_ category: CategoryDTO) {
        let toursForCategory = category.tours ?? []
        viewModel.tours = toursForCategory
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






