//
//  LoginScreenViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation

protocol AuthenticatorService {
    var authService: AuthenticationProtocol {get set}
}

class AuthenticationViewModel : AuthenticatorService {
    
    lazy var authService: AuthenticationProtocol = FirebaseAuthService.shared
    
    func authenticateUser(method : authMethod,credentials: UserCredentials, completion: @escaping (Bool) -> Void) {
        authService.authenticateUser(method: method, credentials: credentials) { result in
            completion(result)
        }
    }
}
