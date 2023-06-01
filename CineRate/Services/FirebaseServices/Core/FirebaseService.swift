//
//  FirebaseService.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation
import UIKit
import Firebase


protocol AuthenticationProtocol {
    func authenticateUser(method : authMethod,credentials: UserCredentials, completion: @escaping (Bool) -> Void)
}

class FirebaseAuthService: AuthenticationProtocol {
    static let shared = FirebaseAuthService()
    
    func authenticateUser(method : authMethod,credentials: UserCredentials, completion: @escaping (Bool) -> Void) {
        let authenticator = Auth.auth()
        if method == .login {
            authenticator.signIn(withEmail: credentials.email, password: credentials.password) { data, error in
                if error != nil {
                    completion(false)
                }else {
                    completion(true)
                }
            }
        }else if method == .signup {
            authenticator.createUser(withEmail: credentials.email, password: credentials.password) { data, error in
                if error != nil {
                    completion(false)
                }else {
                    completion(true)
                }
            }
        }
    }
}
