//
//  LoginScreenViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation

class AuthenticationViewModel {
    private let authService: AuthenticationProtocol
    
    init(authService: AuthenticationProtocol = FirebaseAuthService.shared) {
        self.authService = authService
    }
    
    func authenticateUser(method : authMethod,credentials: UserCredentials, completion: @escaping (Bool) -> Void) {
        authService.authenticateUser(method: method, credentials: credentials) { result in
            completion(result)
        }
    }
}
