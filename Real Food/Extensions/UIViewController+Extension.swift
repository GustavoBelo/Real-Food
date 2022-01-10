//
//  UIViewController+Extension.swift
//  Real Food
//
//  Created by Gustavo Belo on 13/12/21.
//

import UIKit

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
    
    func goToInitial() {
        let controller = InitialViewController.instantiate()
        self.navigationController?.setViewControllers([controller], animated: true)
    }
    
    func createSpinnerView(_ spinnerVC: SpinnerViewController) {
        addChild(spinnerVC)
        spinnerVC.view.frame = view.frame
        view.addSubview(spinnerVC.view)
        spinnerVC.didMove(toParent: self)
    }
    
    func removeSpinnerView(_ spinnerVC: SpinnerViewController) {
        DispatchQueue.main.async {
            spinnerVC.willMove(toParent: nil)
            spinnerVC.view.removeFromSuperview()
            spinnerVC.removeFromParent()
        }
    }
}
