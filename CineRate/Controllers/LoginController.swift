//
//  LoginController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation
import UIKit
import Firebase

class LoginController : UIViewController {
    
    private let authViewModel = AuthenticationViewModel()
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
    // MARK: --
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Setup All Objects and Properties
    
    private func setupViews() {
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
    
    @objc private func buttonClicked(sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        guard email != "" && password != "" else {return}
        
        let method: authMethod = sender == signupButton ? .signup : .login
        let credentials = UserCredentials(email: email, password: password)
        authViewModel.authenticateUser(method: method, credentials: credentials) { isSuccess in
            isSuccess ? self.performSegue(withIdentifier: "toHome", sender: nil) : print("hata")
        }
    }
    
    private func userLoggedIn() {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        performSegue(withIdentifier: "toHome", sender: nil)
    }
    
  
}
