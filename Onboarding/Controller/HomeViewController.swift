//
//  HomeViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 10/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar() {
        self.title = K.NavigationTitles.home
    }
    
}
