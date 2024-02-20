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
        let mainViewModel = TestingMainViewModel()
        let mainViewController = TestingMainViewController(viewModel: mainViewModel)
        window?.rootViewController = mainViewController
    }
}
