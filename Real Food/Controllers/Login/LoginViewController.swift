//
//  LoginViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 08/12/21.
//

import UIKit
import HideKeyboardWhenTappedAround

class LoginViewController: UIViewController {
    @IBAction func loginButton(_ sender: UIButton) {
        let controller = CatchRestaurantNameViewController.instantiate()
        navigationController?.setViewControllers([controller], animated:true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
}

