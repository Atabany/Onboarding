//
//  SettingsViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 09/03/2022.
//

import UIKit
import MBProgressHUD

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    
    private func setupViews() {
        view.backgroundColor = .systemPink
        title = K.NavigationTitles.settings
    }
    
    
    @IBAction func logoutbuttonTapped(_ sender: UIBarButtonItem) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        Helper.delay(durationInSeconds: 2) {
            MBProgressHUD.hide(for: self.view, animated: true)
            PresenterManager.shared.show(vc: .onboarding)
        }
        
    }
    
    
    
    
    
}
