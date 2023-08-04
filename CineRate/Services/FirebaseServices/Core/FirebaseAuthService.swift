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
    func authenticateUser(method : authMethod,credentials: UserCredentials?, completion: @escaping (Bool) -> Void)
}

class FirebaseAuthService: AuthenticationProtocol {
    static let shared = FirebaseAuthService()
    private init() {}
    
    func authenticateUser(method : authMethod,credentials: UserCredentials?, completion: @escaping (Bool) -> Void) {
        
        let authenticator = Auth.auth()
        
        switch method {
            
        case .login:
            guard let credentials = credentials else {return}
            authenticator.signIn(withEmail: credentials.email, password: credentials.password) { data, error in
                if error != nil {
                    completion(false)
                }else {
                    completion(true)
                }
            }
            
        case .signup:
            guard let credentials = credentials else {return}
            authenticator.createUser(withEmail: credentials.email, password: credentials.password) { data, error in
                if error != nil {
                    completion(false)
                }else {
                    completion(true)
                }
            }
            
        case .signout:
            try? authenticator.signOut()
            completion(true)
            
        }
    }
        
}


    
