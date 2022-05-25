//
//  LoginViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 08/12/21.
//

import UIKit
import HideKeyboardWhenTappedAround
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            
            let spinnerVC = SpinnerViewController()
            self.createSpinnerView(spinnerVC)
            
            let firebaseAuth = Auth.auth()
            firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
                self.removeSpinnerView(spinnerVC)
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let controller = HomeViewController()
                    self.navigationController?.setViewControllers([controller], animated:true)
                }
            }
        }
        
    }
}

