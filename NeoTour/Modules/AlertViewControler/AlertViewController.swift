//
//  AlertViewController.swift
//  NeoTour
//
//  Created by anjella on 25/2/24.
//

import UIKit

class AlertViewController: UIViewController {

    var okButtonAction: (() -> Void)?
    
    lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Your trip has been booked!"
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        return label
    }()
    
    private var okButton: UIButton = {
       let button = UIButton()
       button.setTitle("Ok", for: .normal)
        button.backgroundColor = UIColor(red: 106/255,
                                         green: 98/255,
                                         blue: 183/255,
                                         alpha: 1)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)

        return button
    }()
    
    @objc private func okButtonTapped() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    }
    
    override func loadView() {
        super.loadView()
        setUpUI()
    }
}

extension AlertViewController {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(conteinerView)
        conteinerView.addSubview(messageLabel)
        conteinerView.addSubview(okButton)
    }
    
    private func setUpConstraints() {
        conteinerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(190)
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(conteinerView.snp.top).offset(40)
            make.leading.equalTo(conteinerView.snp.leading).offset(20)
            make.trailing.equalTo(conteinerView.snp.trailing).offset(-20)
        }

        okButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(32)
            make.centerX.equalTo(conteinerView.snp.centerX)
            make.leading.equalTo(conteinerView.snp.leading).offset(40)
            make.trailing.equalTo(conteinerView.snp.trailing).offset(-40)
            make.height.equalTo(50)
        }

    }
}

