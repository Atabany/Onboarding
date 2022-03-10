//
//  LoginViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 10/03/2022.
//


import UIKit
import MBProgressHUD

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
    
    
    private let isSuccessfulLogin = true
    
    weak var delegate: LoginViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTF.becomeFirstResponder()
    }
    
    func setupViewController() {
        currentPage = .login
    }
    
    
    private func setupViewsFor(pageType: PageType) {
        errorMsgLabel.text = nil
        
        passwordConfirmationTF.isHidden           = pageType == .login
        signUpButton.isHidden                     = pageType == .login
        loginButton.isHidden                      = pageType == .signUp
        forgetPasswordButton.isHidden             = pageType == .signUp
        
        emailTF.keyboardType                      = .emailAddress
        passwordTF.isSecureTextEntry              = true
        passwordConfirmationTF.isSecureTextEntry  = true
        
        emailTF.becomeFirstResponder()
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
        view.endEditing(true)
        MBProgressHUD.showAdded(to: view, animated: true)
        Helper.delay(durationInSeconds: 2) {
            MBProgressHUD.hide(for: self.view, animated: true)
            if self.isSuccessfulLogin {
                self.delegate.didSuccessfullyLogin()
            } else {
                self.errorMessage = "Your password is invalid, please try again"
            }
        }
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        //        dismiss(animated: true, completion: nil)
        //        delegate.didSuccessfullyLogin()
    }
    
    
    
    
    
}
