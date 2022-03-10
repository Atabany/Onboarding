//
//  OnboardingCollectionViewCell.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 10/03/2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
        @IBOutlet weak var slideImageView: UIImageView!
    
    func configure(image: UIImage) {
        slideImageView.image = image
        slideImageView.contentMode = .scaleAspectFill
    }
    
}
