//
//  PopUpInformationViewController.swift
//  NeoTour
//
//  Created by anjella on 23/2/24.
//

import UIKit

class PopUpInformationViewController: UIViewController {

    private var viewModel: PopUpInformationViewModel
    let genderOptions = ["+996","+7","+8"]    // ADD
    var isDropdownVisible = false
    
    init(viewModel: PopUpInformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Info"
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        return label
    }()
    
    private lazy var reservationInfoLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.text =
        """
        To submit an application for a tour reservation,
        you need to fill in your information and select
        the number of people for the reservation.
        """
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Phone number"
        label.font = UIFont(name: "Avenir Next", size: 14)
        return label
    }()
    
    private lazy var phoneNumberTF: UITextField = {
        var textField = UITextField()
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.textContentType = .init(rawValue: "")
        textField.layer.cornerRadius = 50 / 2
        textField.layer.borderWidth = 1
        textField.layer.borderColor =  UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1).cgColor
        textField.textColor = UIColor(red: 0.008, green: 0.196, blue: 0.275, alpha: 1)
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    
    
    private lazy var commentariesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Commentaries to trip"
        label.font = UIFont(name: "Avenir Next", size: 14)
        return label
    }()
    
    private lazy var commentariesTF: UITextField = {
        var textField = UITextField()
        textField.placeholder = "  Write your wishes to trip..."
        textField.font = UIFont(name: "Avenir Next", size: 16)
        textField.textContentType = .init(rawValue: "")
        textField.layer.cornerRadius = 50 / 2
        textField.layer.borderWidth = 1
        textField.layer.borderColor =  UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1).cgColor
        textField.textColor = UIColor(red: 0.008, green: 0.196, blue: 0.275, alpha: 1)
        textField.isUserInteractionEnabled = true
        return textField
    }()
    
    private lazy var numberOfPeopleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Number of people"
        label.font = UIFont(name: "Avenir Next", size: 14)
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.isUserInteractionEnabled = true
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor =  UIColor(red: 106/255,
                                          green: 98/255,
                                          blue: 183/255,
                                          alpha: 1)
        button.layer.cornerRadius = 14
//        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var numberOfPeoopleLabel: UILabel = {
        let label = UILabel()
//        label.textAlignment = .center
        label.font = UIFont(name: "Avenir Next Bold", size: 16)
        label.textColor = .black
        label.text = "5"
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.isUserInteractionEnabled = true
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor =  UIColor(red: 106/255,
                                          green: 98/255,
                                          blue: 183/255,
                                          alpha: 1)
        button.layer.cornerRadius = 14
//        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var numberOfPeopleView: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.backgroundColor = .systemGray6
        circleView.layer.cornerRadius = 14
        return circleView
    }()
    
    private lazy var peopleIcon: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "peopleIcon")
        return image
    }()
    
    private lazy var peopleCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.textColor = .black
        label.text = "5 people"
        return label
    }()
    
    private let submitButton: UIButton = {  // CHANGE CONSTRAINTS!!!!
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = UIColor(red: 106/255,
                                         green: 98/255,
                                         blue: 183/255,
                                         alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
//        button.addTarget(self, action: #selector(bookNowButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
    }
}

extension PopUpInformationViewController {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        view.addSubview(infoTitleLabel)
        view.addSubview(reservationInfoLabel)
        view.addSubview(phoneNumberLabel)
        view.addSubview(phoneNumberTF)
        view.addSubview(commentariesLabel)
        view.addSubview(commentariesTF)
        view.addSubview(numberOfPeopleLabel)
        
        view.addSubview(numberOfPeopleView)
        numberOfPeopleView.addSubview(minusButton)
        numberOfPeopleView.addSubview(plusButton)
        numberOfPeopleView.addSubview(numberOfPeoopleLabel)
        
        view.addSubview(peopleIcon)
        view.addSubview(peopleCountLabel)
        view.addSubview(submitButton)
        
    }
    
    private func setUpConstraints() {
        infoTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(50)
            $0.height.equalTo(29)
        }
        
        reservationInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(343)
            $0.height.equalTo(51)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(115)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(110)
            $0.height.equalTo(17)
        }
        
        phoneNumberTF.snp.makeConstraints {
            $0.top.equalToSuperview().offset(135)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(370)
            $0.height.equalTo(50)
        }
        
        commentariesLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(203)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(150)
            $0.height.equalTo(17)
        }
        
        commentariesTF.snp.makeConstraints {
            $0.top.equalToSuperview().offset(223)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(370)
            $0.height.equalTo(50)
        }
        
        numberOfPeopleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(288)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(120)
            $0.height.equalTo(17)
        }
        
        numberOfPeopleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(310)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(104)
            $0.height.equalTo(36)
        }
        
        minusButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(29)
            $0.height.equalTo(36)
        }
        
        plusButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(29)
            $0.height.equalTo(36)
        }
        
        numberOfPeoopleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(47)
            $0.width.equalTo(11)
            $0.height.equalTo(19)
        }
        
        peopleIcon.snp.makeConstraints {
            $0.centerY.equalTo(numberOfPeopleView)
            $0.leading.equalTo(numberOfPeopleView.snp.trailing).offset(20)
            $0.width.height.equalTo(24)
        }
        
        peopleCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(peopleIcon)
            $0.leading.equalTo(peopleIcon.snp.trailing).offset(8)
            $0.width.equalTo(80)
            $0.height.equalTo(19)
        }
        
        submitButton.snp.makeConstraints { make in  // CHANGE CONSTRAINTS!!!!
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(375)
        }
    }
}
