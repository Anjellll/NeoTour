//
//  TestingCollectionViewCell.swift
//  NeoTour
//
//  Created by anjella on 22/2/24.
//

import UIKit

class TestingCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    
    private var reviewData: [ReviewsModel] = [
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous", userReview: "Good good good good good Good good good good goodGood good good good good Good good good good good Good good good good good Good good good good good Good good good good good Good good good good good"),
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous2", userReview: "Good good good good good Good good good good good Good good good good good"),
    ReviewsModel(userIcon: "userIcon", userName: "Anonymous3", userReview: "Good good good good good Good good good good goodGood good good good good Good good good good good Good good good good good Good good good good good Good good good good good Good good good good good")
    ]
    
    let verticelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .green
        return stack
    }()
    
    lazy var baseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        collectionView.backgroundColor = .yellow
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollectionView() {
        baseCollectionView.register(TestingCell.self, forCellWithReuseIdentifier: TestingCell.reuseIdentifier)
        baseCollectionView.delegate = self
        baseCollectionView.dataSource = self
    }
}

extension TestingCollectionViewCell {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(verticelStack)
        addSubview(baseCollectionView)
    }
    
    private func setUpConstraints() {
        verticelStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(390)
            make.width.equalTo(410)
        }
        
        baseCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(verticelStack.snp.width)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
       
extension TestingCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(reviewData)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestingCell.reuseIdentifier, for: indexPath) as! TestingCell
        cell.dataReview = reviewData[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 386, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

