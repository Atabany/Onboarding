//
//  SettingsViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 09/03/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
    }
    
    
    private func setupViews() {
        view.backgroundColor = .systemPink
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    
    @IBAction func logoutbuttonTapped(_ sender: UIBarButtonItem) {
        PresenterManager.shared.show(vc: .onboarding)
    }
    
    
    
    
    
}
