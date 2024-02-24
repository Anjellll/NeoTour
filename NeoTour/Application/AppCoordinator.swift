//
//  AppCoordinator.swift
//  NeoTour
//
//  Created by anjella on 14/2/24.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let onboardingViewModel = TestingDetailViewModel()
        let onboardingViewController = TestingDetailViewController(viewModel: onboardingViewModel)
        onboardingViewController.coordinator = self

        window?.rootViewController = onboardingViewController
        window?.makeKeyAndVisible()
    }

    func goToMainScreen() {
        let mainViewModel = TourDetailsViewModel()
        let mainViewController = TourDetailsViewController(viewModel: mainViewModel)
        window?.rootViewController = mainViewController
    }
    
    func bookNowButtonTapped() {
        let viewModel = PopUpInformationViewModel()
        let viewController = PopUpInformationViewController(viewModel: viewModel)
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.present(viewController, animated: true, completion: nil)
        }
        // или, если вы хотите установить его как rootViewController
        // UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}


