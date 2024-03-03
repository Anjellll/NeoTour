//
//  SceneDelegate.swift
//  NeoTour
//
//  Created by anjella on 13/2/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let onboardingViewModel = OnboardingViewModel()
        let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: onboardingViewController)
    }
}

