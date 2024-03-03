//
//  MainCollectionView.swift
//  NeoTour
//
//  Created by anjella on 3/3/24.
//

import UIKit

class MainCollectionView: UICollectionView {
    
    private var mainDataSource: UICollectionViewDiffableDataSource<MainViewController.Section, MainViewController.Item>!

    init(frame: CGRect) {
        let layout = MainCollectionView.createLayout(for: .categoryTours, isWide: false)
        super.init(frame: frame, collectionViewLayout: layout)
        registerCells()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        register(ToursCategoryCollectionViewCell.self, forCellWithReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier)
        register(TourCollectionViewCell.self, forCellWithReuseIdentifier: TourCollectionViewCell.reuseIdentifier)
        register(RecommendedToursCollectionCell.self, forCellWithReuseIdentifier: RecommendedToursCollectionCell.reuseIdentifier)
        register(HeaderView.self, forSupplementaryViewOfKind: MainViewController.sectionHeaderElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<MainViewController.Section, MainViewController.Item>(collectionView: self) { collectionView, indexPath, item in
            switch item {
            case .category(let data):
                return MainCollectionView.configureCategoryCell(collectionView: collectionView, indexPath: indexPath, data: data)
            case .galery(let data):
                return MainCollectionView.configureGaleryCell(collectionView: collectionView, indexPath: indexPath, data: data)
            case .recommended(let data):
                return MainCollectionView.configureRecommendedCell(collectionView: collectionView, indexPath: indexPath, data: data)
            }
        }
        
        mainDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return MainCollectionView.configureHeaderView(collectionView: collectionView, kind: kind, indexPath: indexPath) ?? UICollectionReusableView()
        }

    }
    
    private static func configureCategoryCell(collectionView: UICollectionView, indexPath: IndexPath, data: CategoryDTO) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ToursCategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? ToursCategoryCollectionViewCell else {
            fatalError("Failed to dequeue a cell of type ToursCategoryCollectionViewCell")
        }
        cell.displayInfo(tours: data)
        return cell
    }

    private static func configureGaleryCell(collectionView: UICollectionView, indexPath: IndexPath, data: TourDTO) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourCollectionViewCell.reuseIdentifier, for: indexPath) as! TourCollectionViewCell
        cell.configure(tour: data)
        return cell
    }

    private static func configureRecommendedCell(collectionView: UICollectionView, indexPath: IndexPath, data: TourDTO) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedToursCollectionCell.reuseIdentifier, for: indexPath) as! RecommendedToursCollectionCell
        cell.setUpRecommendedView(tour: data)
        return cell
    }

    private static func configureHeaderView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> HeaderView? {
        if let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.reuseIdentifier,
            for: indexPath
        ) as? HeaderView {
            supplementaryView.label.text = "Recommended"
            return supplementaryView
        } else {
            // Возвращаем nil в случае, если не удается создать HeaderView
            return nil
        }
    }

    
    private static func createLayout(for section: MainViewController.Section, isWide: Bool) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch section {
            case .categoryTours:
                return generateCategoryLayout(isWide: isWide)
            case .galeryTour:
                return generateToursLayout(isWide: isWide)
            case .recommendedTours:
                return generateRecommendedTourLayout()
            }
        }
    }

    private static func generateCategoryLayout(isWide: Bool) -> NSCollectionLayoutSection {
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

    private static func generateRecommendedTourLayout() -> NSCollectionLayoutSection {
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

    private static func generateToursLayout(isWide: Bool) -> NSCollectionLayoutSection {
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
