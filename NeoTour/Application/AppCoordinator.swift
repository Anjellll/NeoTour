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
        let onboardingViewModel = OnboardingViewModel()
        let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
        onboardingViewController.coordinator = self

        window?.rootViewController = onboardingViewController
        window?.makeKeyAndVisible()
    }

    func goToMainScreen() {
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController(viewModel: mainViewModel)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navigationController
    }
    
    func showDetail(with data: TourDTO) {
        let viewModel = DetailViewModel()
        let detailViewController = DetailViewController(viewModel: viewModel)
        detailViewController.tour = data

        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.pushViewController(detailViewController, animated: true)
        } else {
        }
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
    }
}
