//
//  PopUpView.swift
//  NeoTour
//
//  Created by anjella on 3/3/24.
//

import UIKit

class PopUpView: UIView {
    
    private var viewModel: PopUpInformationViewModel
    var tour: TourDTO?
    var selectedTourID: String?
    weak var parentViewController: UIViewController?

    let tableView = UITableView()
    let codeOptions = ["+996","+7","+8"]
    let flagImages = [
        "+996": UIImage(named: "flag_kg"),
        "+7": UIImage(named: "flag_ru"),
        "+8": UIImage(named: "flag_kz")
    ]
    var isDropdownVisible = false
    
    init(frame: CGRect, viewModel: PopUpInformationViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        setUpUI()
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
        textField.layer.borderColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1).cgColor
        textField.textColor = .black
        textField.isUserInteractionEnabled = true

        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 125, height: textField.frame.height))
        textField.leftView = leftPadding
        textField.leftViewMode = .always

        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.rightView = rightPadding
        textField.rightViewMode = .always

        return textField
    }()

    private lazy var countryImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "flag_kg")
        return image
    }()
    
    private var arrowIconButton: UIButton = {
       let button = UIButton()
        let image = UIImage(named: "arrowIcon")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(showSmallView), for: .touchUpInside)
        return button
    }()
    
    private var inputLabel: UILabel = {
        let label = UILabel()
        label.text = "+996"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 16)
       return label
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
        textField.textColor = .black
        textField.isUserInteractionEnabled = true
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = leftPadding
        textField.leftViewMode = .always
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.rightView = rightPadding
        textField.rightViewMode = .always
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
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var numberOfPeoopleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 16)
        label.textColor = .black
        label.text = "\(viewModel.currentPeopleCount)"
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
        button.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
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
        label.text = "\(viewModel.currentPeopleCount) people"
        return label
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = UIColor(red: 106/255,
                                         green: 98/255,
                                         blue: 183/255,
                                         alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
//        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    @objc func showSmallView() {
        isDropdownVisible.toggle()

        tableView.isHidden = !isDropdownVisible
        tableView.reloadData()

        commentariesTF.isUserInteractionEnabled = !isDropdownVisible

        if isDropdownVisible {
            tableView.snp.updateConstraints { make in
                make.height.equalTo(130)
            }
        } else {
            tableView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        }

        UIView.animate(withDuration: 0.3) {
            self.superview?.layoutIfNeeded()
        }
    }
    
//    @objc private func submitButtonTapped() {
//        guard viewModel.isSubmitButtonEnabled else {
//            return
//        }
//
//        guard let tourID = tour?.tourID else {
//            print("⚠️Ошибка: Не удалось получить tourID")
//            return
//        }
//        let phoneNumber = viewModel.phoneNumber ?? ""
//        let commentaries = viewModel.commentaries ?? ""
//        let numberOfPeople = viewModel.currentPeopleCount
//        let apiType = NetworkAPI.addReservation(tourID: tourID, phoneNumber: phoneNumber, reservationComment: commentaries, numberOfPeople: numberOfPeople)
//
//        NetworkLayer.shared.addReservation(apiType: apiType, tourID: tourID, phoneNumber: phoneNumber, reservationComment: commentaries, numberOfPeople: numberOfPeople) { result in
//            switch result {
//            case .success(let message):
//                DispatchQueue.main.async {
//                    self.parentViewController?.showAlert(with: "Успешно", message: "Ваше бронирование успешно! Бронирование ID: \(message)")
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    var errorMessage = "Тур не может быть забронирован."
//                    if let data = error.localizedDescription.data(using: .utf8) {
//                        do {
//                            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                            if let serverError = json?["error"] as? String {
//                                errorMessage = serverError
//                            }
//                        } catch {
//                            errorMessage = error.localizedDescription
//                        }
//                    }
//                    self.parentViewController?.showAlert(with: "Ошибка", message: errorMessage)
//                }
//            }
//        }
//    }
    
    @objc private func plusButtonTapped() {
        viewModel.incrementPeopleCount()
        updatePeopleCountLabel()
        updateButtonsState()
    }
    
    @objc private func minusButtonTapped() {
        viewModel.decrementPeopleCount()
        updatePeopleCountLabel()
        updateButtonsState()
    }
    
    private func updatePeopleCountLabel() {
        numberOfPeoopleLabel.text = "\(viewModel.currentPeopleCount)"
        peopleCountLabel.text = "\(viewModel.currentPeopleCount) people"
    }
    
    private func updateButtonsState() {
        plusButton.isEnabled = viewModel.isPlusButtonEnabled
        minusButton.isEnabled = viewModel.isMinusButtonEnabled
        
        plusButton.backgroundColor = viewModel.isPlusButtonEnabled ?
        UIColor(red: 106/255, green: 98/255, blue: 183/255, alpha: 1) : .gray
        
        minusButton.backgroundColor = viewModel.isMinusButtonEnabled ?
        UIColor(red: 106/255, green: 98/255, blue: 183/255, alpha: 1) : .gray
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.isHidden = true
    }
}

extension PopUpView {
    private func setUpUI() {
        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(tableView)
        addSubview(infoTitleLabel)
        addSubview(reservationInfoLabel)
        addSubview(phoneNumberLabel)
        addSubview(phoneNumberTF)
        phoneNumberTF.addSubview(countryImage)
        phoneNumberTF.addSubview(arrowIconButton)
        phoneNumberTF.addSubview(inputLabel)
        addSubview(commentariesLabel)
        addSubview(commentariesTF)
        addSubview(numberOfPeopleLabel)
        
        addSubview(numberOfPeopleView)
        numberOfPeopleView.addSubview(minusButton)
        numberOfPeopleView.addSubview(plusButton)
        numberOfPeopleView.addSubview(numberOfPeoopleLabel)
        
        addSubview(peopleIcon)
        addSubview(peopleCountLabel)
        addSubview(submitButton)
        
    }
    
    private func setUpConstraints() {
        guard let superview = superview else {
            return
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(inputLabel.snp.bottom).offset(16)
            make.leading.equalTo(superview.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(superview.safeAreaLayoutGuide).offset(-220)
            make.height.equalTo(0) // Высота будет меняться в зависимости от состояния шторки
        }
        
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
        
        countryImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(24)
        }
        
        arrowIconButton.snp.makeConstraints {
            $0.centerY.equalTo(countryImage)
            $0.leading.equalTo(countryImage.snp.trailing).offset(8)
            $0.width.height.equalTo(24)
        }
        
        inputLabel.snp.makeConstraints {
            $0.centerY.equalTo(countryImage)
            $0.leading.equalTo(countryImage.snp.trailing).offset(40)
            $0.height.equalTo(18)
            $0.width.equalTo(70)
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
        
        submitButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(375)
        }
    }
}

extension PopUpView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemGray2

        let code = codeOptions[indexPath.row]
        cell.textLabel?.text = code

        if let flagImage = flagImages[code] {
            cell.imageView?.image = flagImage
        } else {
            cell.imageView?.image = UIImage(named: "flag_kg")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCode = codeOptions[indexPath.row]
        inputLabel.text = selectedCode
        showSmallView()
        if let flagImage = flagImages[selectedCode] {
            countryImage.image = flagImage
        }
    }
}





//import UIKit
//
//extension UIViewController {
//    func showAlert(with title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
//}
