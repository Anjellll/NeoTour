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
        
        window?.rootViewController = onboardingViewController
    }
}

