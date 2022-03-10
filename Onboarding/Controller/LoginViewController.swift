//
//  LoginViewController.swift
//  Onboarding
//
//  Created by Mohamed Elatabany on 10/03/2022.
//


import UIKit
import MBProgressHUD
import Loaf
import Combine



protocol LoginViewControllerDelegate: AnyObject {
    func showHome()
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
    
    private let authManager = AuthManager()
    
    weak var delegate: LoginViewControllerDelegate!
    
    
    var subscriber: AnyCancellable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        observeTextFields()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailTF.becomeFirstResponder()
    }
    
    
    
    func setupViewController() {
        currentPage = .login
        [emailTF, passwordTF, passwordConfirmationTF].forEach {
            $0?.clearButtonMode = .whileEditing
        }
    }
    
    private func observeTextFields() {
        subscriber = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
            .sink { [unowned self] notification in
                guard let _ = notification.object as? UITextField else {return}
                self.errorMessage = nil
            }
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
        let alertController = UIAlertController(title: "Forget Password", message: "Please enter your email address", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard let self = self else {return}
            if let tf = alertController.textFields?.first, let email = tf.text, !email.isEmpty {
                self.authManager.resetPassword(withEmail: email) { [weak self] result in
                    guard let self = self else {return}
                    switch result {
                    case .success:
                        self.showAlert(title: "Password Reset Successful", message: "Please check your email to find the password reset")
                    case .failure(let error):
                        Loaf(error.localizedDescription, state: .error, location: .bottom, sender: self).show()
                    }
                }
            }
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        loginUser()
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        singUpUser()
    }
    
    
    private func loginUser() {
        validateInputs(pageType: .login) { result in
            switch result {
            case .success((let email , let password)):
                MBProgressHUD.showAdded(to: view, animated: true)
                authManager.loginUser(withEmail: email, password: password) { [weak self] result in
                    guard let self = self else {return}
                    MBProgressHUD.hide(for: self.view, animated: true)
                    switch result {
                    case .success :
                        self.delegate.showHome()
                    case .failure(let error):
                        if let error = error as? AuthError {
                            self.errorMessage = error.errorDescription
                        } else {
                            self.errorMessage = error.localizedDescription
                        }
                    }
                }
            case .failure(let error):
                errorMessage = error.rawValue
            }
        }
        
    }
    
    private func singUpUser() {
        validateInputs(pageType: .signUp) { result in
            switch result {
            case .success((let email , let password)):
                MBProgressHUD.showAdded(to: view, animated: true)
                authManager.signUpNewUser(withEmail: email, password: password) {[weak self] result in
                    guard let self = self else {return}
                    MBProgressHUD.hide(for: self.view, animated: true)
                    switch result {
                    case .success:
                        self.delegate.showHome()
                    case .failure(let error):
                        if let error = error as? AuthError {
                            self.errorMessage = error.errorDescription
                        } else {
                            self.errorMessage = error.localizedDescription
                        }
                    }
                }
            case .failure(let error):
                errorMessage = error.rawValue
            }
        }
    }
    
    
    private func validateInputs(pageType: PageType, completion: (Result<(email: String,password:String),  K.ErrorMessage>) -> ())  {
        switch pageType {
        case .login:
            guard  let email = emailTF.text, !email.isEmpty,
                   let password = passwordTF.text, !password.isEmpty
            else {
                completion(.failure(.invalidForm))
                return
            }
            completion(.success((email: email, password: password)))
        case .signUp:
            guard  let email = emailTF.text, !email.isEmpty,
                   let password = passwordTF.text, !password.isEmpty,
                   let passwordConfimation = passwordConfirmationTF.text, !passwordConfimation.isEmpty
            else {
                completion(.failure(.invalidForm))
                return
            }
            
            guard password == passwordConfimation else {
                completion(.failure(.passowrdIncorrect))
                return
            }
            completion(.success((email: email, password: password)))
        }
   
    }
    
    
    
}
