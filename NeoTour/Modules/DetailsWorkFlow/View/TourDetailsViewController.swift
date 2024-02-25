//
//  TourDetailsViewController.swift
//  NeoTour
//
//  Created by anjella on 21/2/24.
//

import UIKit
    
class TourDetailsViewController: UIViewController, ReuseIdentifying {

    private var viewModel: TourDetailsViewModel
    weak var coordinator: AppCoordinator?
    var collectionView: UICollectionView?
    
    init(viewModel: TourDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override func loadView() {
        super.loadView()
        registerCell()
        configureCollectionView()
    }
}

extension  {
    
    func registerCell() {
        collectionView?.register(TestingCollectionViewCell.self, forCellWithReuseIdentifier: TestingCollectionViewCell.reuseIdentifier)
        collectionView?.register(TourDetilsCollectionCell.self, forCellWithReuseIdentifier: TourDetilsCollectionCell.reuseIdentifier)
    }

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        // Инициализация collectionView
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .red

        // Убедитесь, что collectionView не равно nil
        guard let collectionView = collectionView else {
            return
        }

        // Регистрация ячейки
        collectionView.register(TestingCollectionViewCell.self, forCellWithReuseIdentifier: TestingCollectionViewCell.reuseIdentifier)
        
        collectionView.register(TourDetilsCollectionCell.self, forCellWithReuseIdentifier: TourDetilsCollectionCell.reuseIdentifier)

        view.addSubview(collectionView)
    }
}

extension TourDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourDetilsCollectionCell.reuseIdentifier, for: indexPath) as! TourDetilsCollectionCell
            return cell
        }  else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestingCollectionViewCell.reuseIdentifier, for: indexPath) as! TestingCollectionViewCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestingCollectionViewCell.reuseIdentifier, for: indexPath) as! TestingCollectionViewCell
        return cell
    } 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width, height: 700)
        } else if indexPath.item == 1 {
            return CGSize(width: collectionView.frame.width, height: 600)
        }
        return CGSize(width: collectionView.frame.width, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}


