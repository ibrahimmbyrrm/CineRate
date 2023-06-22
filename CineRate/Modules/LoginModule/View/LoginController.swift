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
        button.addTarget(nil, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    private let signupButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 10
        button.setTitle("Signup", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(buttonClicked), for: .touchUpInside)
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
    
    func addSubviews() {
        [logoImage,emailTextField,passwordTextField,loginButton,signupButton].forEach { v in
            view.addSubview(v)
        }
    }
    
    func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(logoImage.snp.bottom).offset(10)
            make.width.equalTo(300)
        }
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.width.equalTo(300)
        }
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField.snp.leading)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(emailTextField.snp.width).multipliedBy(0.5)
        }
        signupButton.snp.makeConstraints { make in
            make.leading.equalTo(loginButton.snp.trailing).offset(10)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(loginButton.snp.width)
        }
    }
}

