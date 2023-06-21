//
//  LoginController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation
import UIKit
import Firebase

class LoginController : UIViewController{
    
    // MARK: - Programmatic UI Objects
    private let logoImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let passwordTextField : UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    private let signupButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 10
        button.setTitle("Signup", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
        
    }()
    
    private let authViewModel = AuthenticationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authViewModel.loginDelegate = self
        authViewModel.viewDidLoad()
    }
    
    @objc private func buttonClicked(sender: UIButton) {
        let method: authMethod = sender == signupButton ? .signup : .login
        authViewModel.createCredential(method: method, mail: emailTextField.text, password: passwordTextField.text)
        
    }
}
extension LoginController : LoginControllerInterface {
    // MARK: - Segue Performer
    func jumpToHomeScreen() {
        self.performSegue(withIdentifier: Constants.Identifiers.loginToHomeSegue, sender: nil)
    }
    
    // MARK: - Setup All Objects and Properties
    
    func setupViews() {
        view.addSubview(logoImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        
        NSLayoutConstraint.activate([
            
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 200),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 10),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalTo: emailTextField.widthAnchor, multiplier: 0.5),
                    
            signupButton.leadingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: 10),
            signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signupButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor)
        
        ])
    }
}

