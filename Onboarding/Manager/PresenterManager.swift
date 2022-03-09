//
//  PresenterManager.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 09/03/2022.
//

import UIKit

class PresenterManager {
    
    static let shared = PresenterManager()
    private init() {}
    
    
    enum VC {
        case mainTabBarController
        case onboarding
    }
    
    func show(vc: VC) {
        var sceneId: String
        
        switch vc {
        case .mainTabBarController:
            sceneId = K.StoryboardScenesIdentifier.mainTabBarController
        case .onboarding:
            sceneId = K.StoryboardScenesIdentifier.onboardingViewController
        }
        
        let viewController = UIStoryboard(name: K.Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: sceneId)
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {return}
        window.rootViewController = viewController
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
    }
    
}
