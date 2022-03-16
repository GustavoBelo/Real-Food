//
//  UIView+Extension.swift
//  Real Food
//
//  Created by Gustavo Belo on 09/12/21.
//

import Foundation
import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func bindToSuperview() {
        if let superview = self.superview{
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor),
                leftAnchor.constraint(equalTo: superview.leftAnchor),
                rightAnchor.constraint(equalTo: superview.rightAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
        }
    }
}
