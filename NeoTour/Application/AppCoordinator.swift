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
}
