//
//  DetailViewController.swift
//  NeoTour
//
//  Created by anjella on 22/2/24.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel: DetailViewModel
    lazy var contentView = DetailView()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setUpCollectionView()
        view.backgroundColor = .white
        contentView.bookNowButton.addTarget(self, action: #selector(bookNowButtonTapped), for: .touchUpInside)
    }
    
    private func updateUI() {
        contentView.updateView(tour: viewModel.tour)
    }
    
    func setUpCollectionView() {
        contentView.baseCollectionView.delegate = self
        contentView.baseCollectionView.dataSource = self
    }
    
    @objc func bookNowButtonTapped() {
        let popUpViewModel = PopUpInformationViewModel(tour: viewModel.tour)
        let popUpViewController = PopUpInformationViewController(viewModel: popUpViewModel)
        popUpViewController.configure(with: popUpViewModel)
        presentPopUpViewController(viewController: popUpViewController)

        if let sheet = popUpViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
    }

    func presentPopUpViewController(viewController: UIViewController) {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(viewController, animated: true, completion: nil)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getReviewCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourDetailsCell.reuseIdentifier, for: indexPath) as! TourDetailsCell
        cell.configure(data: viewModel.getReview(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 386, height: 120)
    }
}



   
