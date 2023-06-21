//
//  LoginContracts.swift
//  CineRate
//
//  Created by İbrahim Bayram on 21.06.2023.
//

import Foundation

protocol AuthenticatorService {
    var authService: AuthenticationProtocol {get set}
    var loginDelegate : LoginControllerInterface? {get}
    
    func viewDidLoad()
    func createCredential(method: authMethod,mail : String?,password : String?)
}

protocol LoginControllerInterface {
    func setupViews()
    func jumpToHomeScreen()
}

