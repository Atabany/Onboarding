//
//  SettingsViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 09/03/2022.
//

import UIKit
import MBProgressHUD
import Loaf

class SettingsViewController: UIViewController {
    
    private let authManager = AuthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        title = K.NavigationTitles.settings
    }
    
    
    @IBAction func logoutbuttonTapped(_ sender: UIBarButtonItem) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Helper.delay(durationInSeconds: 0.7) { [weak self] in
            guard let self = self else {return}
            MBProgressHUD.hide(for: self.view, animated: true)
            let result = self.authManager.logoutUser()
            switch result {
            case .success:
                PresenterManager.shared.show(vc: .onboarding)
            case .failure(let error):
                Loaf(error.localizedDescription, state: .error, location: .bottom, sender: self).show()
                print()
            }
        }
    }

    
}
