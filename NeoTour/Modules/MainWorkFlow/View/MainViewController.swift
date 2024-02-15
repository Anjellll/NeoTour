//
//  MainViewController.swift
//  NeoTour
//
//  Created by anjella on 15/2/24.
//

import UIKit

class MainViewController: UIViewController {

    private var viewModel: MainViewModel?
    
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
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray2
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
    }
    
    private func setUpSubviews() {
        view.addSubview(discoverLabel)
    }
    
    private func setUpConstraints() {
        discoverLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(139)
            $0.height.equalTo(38)
        }
    }
}
