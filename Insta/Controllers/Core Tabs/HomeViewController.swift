//
//  ViewController.swift
//  Insta
//
//  Created by Tomasz Stevens on 26/08/2020.
//  Copyright © 2020 Tomasz Stevens. All rights reserved.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        do {
//            try Auth.auth().signOut()
//            print("signed out")
//        }
//        catch {
//            print("failed to sign out")
//        }
        handleNotAuthenticated()
        
    }
    
    private func handleNotAuthenticated() {
        // Check auth status
        if Auth.auth().currentUser == nil {
            // Show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }

}

