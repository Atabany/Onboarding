//
//  LoginViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 10/03/2022.
//


import UIKit


protocol LoginViewControllerDelegate: AnyObject {
    func didSuccessfullyLogin()
}


class LoginViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordConfirmationTF: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorMsgLabel: UILabel!
    
    
    private enum PageType: Int {
        case login
        case signUp
    }
    
    private var currentPage: PageType! {
        didSet {
            setupViewsFor(pageType: currentPage)
        }
    }
    
    private var errorMessage: String? {
        didSet {
            showError(msg: errorMessage)
        }
    }
    
    
    private let isSuccessfulLogin = false
    
    weak var delegate: LoginViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    
    func setupViewController() {
        currentPage = .login
    }
    
    
    private func setupViewsFor(pageType: PageType) {
        self.errorMsgLabel.text = nil
        self.passwordConfirmationTF.isHidden = pageType == .login
        self.signUpButton.isHidden           = pageType == .login
        self.loginButton.isHidden            = pageType == .signUp
        self.forgetPasswordButton.isHidden   = pageType == .signUp
    }
    
    private func showError(msg: String?) {
        errorMsgLabel.isHidden = msg  == nil
        errorMsgLabel.text = msg
    }
    
    
    
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        currentPage = PageType(rawValue: sender.selectedSegmentIndex) ?? .login
    }
    
    
    @IBAction func forgetPasswordButtonTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if isSuccessfulLogin {
            delegate.didSuccessfullyLogin()
        } else {
            errorMessage = "Your password is invalid, please try again"
        }
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        //        dismiss(animated: true, completion: nil)
        //        delegate.didSuccessfullyLogin()
    }
    
    
    
    
    
}
