//
//  LoginScreenViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import UIKit

class AuthenticationViewModel : AuthenticatorService {
    
    var loginDelegate: LoginControllerInterface?
    
    var authService: AuthenticationProtocol
    
    init(service : AuthenticationProtocol) {
        self.authService = service
    }
    
    
    func authenticateUser(method : authMethod,credentials: UserCredentials, completion: @escaping (Bool) -> Void) {
        authService.authenticateUser(method: method, credentials: credentials) { result in
            completion(result)
        }
    }
    
    func viewDidLoad() {
        loginDelegate?.addSubviews()
        loginDelegate?.setupConstraints()
        
    }
    
    func createCredential(method: authMethod,mail : String?,password : String?) {
        guard let mail,let password else {return}
        let credentials = UserCredentials(email: mail, password: password)
        authenticateUser(method: method, credentials: credentials) { [weak self] isSuccess in
            if isSuccess {
                self?.loginDelegate?.jumpToHomeScreen()
            }else {
                let alert = UIAlertController(title: "Error", message: "Wrong email or password", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okButton)
                self?.loginDelegate?.showAlert(errorVC: alert)
            }
        }
    }
}
