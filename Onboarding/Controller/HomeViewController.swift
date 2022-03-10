//
//  HomeViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 10/03/2022.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar() {
        self.title = K.NavigationTitles.home
        
        if let user = Auth.auth().currentUser {
            self.emailLabel.text = user.email ?? "user email"
        } else {
            self.emailLabel.text = "user email: "
        }
    }
    
}
