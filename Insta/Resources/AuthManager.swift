//
//  AuthManager.swift
//  Insta
//
//  Created by Tomasz Stevens on 26/08/2020.
//  Copyright © 2020 Tomasz Stevens. All rights reserved.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK : - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - Check if username is available
         - Check if email is available
         
         */
        DatabaseManager.shared.canCreateNewUser(email: email, username: username) { canCreate in
            if canCreate {
                /*
                - Create account
                - Insert account to database
                */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        // Firebase auth could not create account
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(email: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            // Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                    completion(true)
                }
            }
            else {
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            print(username)
        }
    }
    
}
