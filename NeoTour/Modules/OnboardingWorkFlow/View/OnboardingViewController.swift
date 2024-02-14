//
//  OnboardingViewController.swift
//  NeoTour
//
//  Created by anjella on 13/2/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private var viewModel: OnboardingViewModel?
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
