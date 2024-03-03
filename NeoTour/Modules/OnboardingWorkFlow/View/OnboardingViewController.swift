//
//  OnboardingViewController.swift
//  NeoTour
//
//  Created by anjella on 13/2/24.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController, OnboardingViewModelType {
    
    private var viewModel: OnboardingViewModel
    
     init(viewModel: OnboardingViewModel) {
         self.viewModel = viewModel
         super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var placeImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "place_image")
        image.layer.cornerRadius = 37
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var placeName: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.text = """
        Winter
        Vacation Trips
        """
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 36, weight: .bold)
        return name
    }()
    
    private lazy var placeDescription: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
        name.textAlignment = .left
        name.text = """
        Enjoy your winter vacations with warmth
        and amazing sightseeing on the mountains.
        Enjoy the best experience with us!
        """
        name.font = .systemFont(ofSize: 16, weight: .regular)
        return name
    }()
    
    private lazy var letsGoButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleToFill
        button.contentHorizontalAlignment = .left
        button.isUserInteractionEnabled = true
        button.setTitle("Let's Go", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 106/255,
                                         green: 98/255,
                                         blue: 183/255,
                                         alpha: 1)
        let image = UIImage(systemName: "arrow.right")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 130, bottom: 0, right: 0)
        button.imageView?.contentMode = .right
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
    
    @objc private func goToMainScreen() {
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController(viewModel: mainViewModel)
        navigationController?.pushViewController(mainViewController, animated: true)
    }
}

extension OnboardingViewController {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(placeImage)
        view.addSubview(placeName)
        view.addSubview(placeDescription)
        view.addSubview(letsGoButton)
    }
    
    private func setUpConstraints() {
        placeImage.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.width.equalTo(415)
            $0.height.equalTo(480)
        }
        
        placeName.snp.makeConstraints {
            $0.top.equalToSuperview().offset(512)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(283)
            $0.height.equalTo(86)
        }
        
        placeDescription.snp.makeConstraints {
            $0.top.equalToSuperview().offset(610)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(293)
            $0.height.equalTo(78)
        }
        
        letsGoButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(728)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(177)
            $0.height.equalTo(53)
        }
    }
}

