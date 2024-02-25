//
//  PopUpInformationViewModel.swift
//  NeoTour
//
//  Created by anjella on 23/2/24.
//

import UIKit

protocol PopUpInformationViewModelProtocol {
    var phoneNumber: String? { get set }
    var commentaries: String? { get set }
    var isSubmitButtonEnabled: Bool { get }
    var phoneNumberBorderColor: UIColor { get }
    var commentariesBorderColor: UIColor { get }

    func phoneNumberDidChange(_ text: String)
    func commentariesDidChange(_ text: String)
    func submitButtonTapped(completion: @escaping () -> Void)
    
    var currentPeopleCount: Int { get }
    var isMinusButtonEnabled: Bool { get }
    var isPlusButtonEnabled: Bool { get }
    
    func incrementPeopleCount()
    func decrementPeopleCount()
}

class PopUpInformationViewModel: PopUpInformationViewModelProtocol {
    
    private var peopleCount: Int = 1
    
    var currentPeopleCount: Int {
        return peopleCount
    }
    
    var isMinusButtonEnabled: Bool {
        return peopleCount > 1
    }
    
    var isPlusButtonEnabled: Bool {
        return peopleCount < 6
    }
    
    func incrementPeopleCount() {
        guard peopleCount < 6 else { return }
        peopleCount += 1
    }
    
    func decrementPeopleCount() {
        guard peopleCount > 1 else { return }
        peopleCount -= 1
    }
    
    var phoneNumber: String?
    var commentaries: String?
    var showAlertClosure: (() -> Void)?

    var isSubmitButtonEnabled: Bool {
        return !(phoneNumber?.isEmpty ?? true) && !(commentaries?.isEmpty ?? true)
    }

    var phoneNumberBorderColor: UIColor {
        return phoneNumber?.isEmpty == true ? .gray : .black
    }

    var commentariesBorderColor: UIColor {
        return commentaries?.isEmpty == true ? .gray : .black
    }

    func phoneNumberDidChange(_ text: String) {
        phoneNumber = text
    }

    func commentariesDidChange(_ text: String) {
        commentaries = text
    }

    func submitButtonTapped(completion: @escaping () -> Void) {
        if isSubmitButtonEnabled {
            showAlertClosure?() 
            completion()
        }
    }
}
