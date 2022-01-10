//
//  RegisterViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/12/21.
//

import UIKit
import Firebase
import HideKeyboardWhenTappedAround

class RegisterViewController: UIViewController {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmedPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text,
           let password = passwordTextField.text,
           passwordTextField.text == confirmedPasswordTextField.text {
            
            let spinnerVC = SpinnerViewController()
            self.createSpinnerView(spinnerVC)
            
            let firebaseAuth = Auth.auth()
            firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
                self.removeSpinnerView(spinnerVC)
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let controller = CatchRestaurantNameViewController.instantiate()
                    self.navigationController?.setViewControllers([controller], animated:true)
                }
            }
            
        }
    }
    
}

