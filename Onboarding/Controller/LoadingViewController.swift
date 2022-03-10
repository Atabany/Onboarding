//
//  LoadinViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 09/03/2022.
//

import UIKit


class LoadingViewController: UIViewController {
     

    let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Helper.delay(durationInSeconds: 2) {
            self.showInitialView()
        }
    }
    
    
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func showInitialView() {
        if authManager.isUserLoggedIn {
            PresenterManager.shared.show(vc: .mainTabBarController)
        } else {
            performSegue(withIdentifier: K.Segues.showOnboarding, sender: nil)
        }
    }
    
    
    
    
}
