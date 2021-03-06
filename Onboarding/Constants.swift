//
//  Constants.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 09/03/2022.
//

import Foundation

enum K {
    
    enum NavigationTitles {
        static let settings = "Settings"
        static let home     = "Home"
    }
    
    
    enum Segues {
        static let showOnboarding = "showOnboarding"
        static let showLoginSignup = "showLoginSignup"

        
    }


    enum StoryboardScenesIdentifier {
        static let mainTabBarController = "MainTabBarController"
        static let onboardingViewController = "OnboardingViewController"
        
    }

    enum Storyboards {
        static let main = "Main"
    }
    
    
    enum Cells {
        static let onboardingCollectionViewCell = "OnboardingCollectionViewCell"
    }
    
    
    enum ErrorMessage: String, Error {
        case invalidForm = "Invalid Form"
        case passowrdIncorrect = "Password and confirmation doesn't match"
    }
}



