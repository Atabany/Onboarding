//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 09/03/2022.
//

import Foundation
import UIKit
class OnboardingViewController: UIViewController {
    
    //MARK: - IB Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControlIndicator: UIPageControl!

    //MARK: - Variables
    var currentIndex = 0 {
        didSet {
            if currentIndex < 0 {
                currentIndex = 0
                return
            } else if currentIndex == Slide.collection.count {
                currentIndex = Slide.collection.count - 1
                return
            }
            guard currentIndex != oldValue else {return}
            updateUI(with: currentIndex)
        }
    }
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seutpViewController()
    }

    private func seutpViewController() {
        setupCollectionView()
        view.backgroundColor = .systemGroupedBackground
        addSwipeGestures()
        pageControlIndicator.numberOfPages = Slide.collection.count
        
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
    }
    
    private func updateUI(with index: Int) {
        collectionView.reloadData()
        setTexts(with: index)
        animateTexts()
        pageControlIndicator.currentPage = currentIndex
    }
    
    private func setTexts(with index: Int) {
        titleLabel.text = Slide.collection[index].title
        descriptionLabel.text = Slide.collection[index].description
    }
    
    
    
    
    
    
    private func animateTexts() {
        titleLabel.alpha = 0
        descriptionLabel.alpha = 0
        UIView.animate(withDuration: 1.4) {
            self.titleLabel.alpha = 1
            self.descriptionLabel.alpha = 1
        }
    }
    
    
    private func addSwipeGestures() {
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(self.userDidSwipeRight))
        swipeGestureRight.direction = .right

        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.userDidSwipeLeft))
        swipeGestureLeft.direction = .left
        
        view.addGestureRecognizer(swipeGestureLeft)
        view.addGestureRecognizer(swipeGestureRight)
    }
    
    @objc
    func userDidSwipeRight() {
        currentIndex -= 1
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .bottom, animated: true)
    }

    @objc
    func userDidSwipeLeft() {
        currentIndex += 1
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .bottom, animated: true)
    }

    
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.showLoginSignup, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LoginViewController else {return}
        destination.delegate = self
    }
}


extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cells.onboardingCollectionViewCell, for: indexPath) as? OnboardingCollectionViewCell, let image = UIImage(named: Slide.collection[indexPath.item].imageName) else {return UICollectionViewCell()}
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .gray
        cell.configure(image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Slide.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.currentIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

}


extension OnboardingViewController: LoginViewControllerDelegate {
    func didSuccessfullyLogin() {
        if let presentedVC = presentedViewController as? LoginViewController {
            presentedVC.dismiss(animated: true) {
                PresenterManager.shared.show(vc: .mainTabBarController)
            }
        }
    }
    
}
