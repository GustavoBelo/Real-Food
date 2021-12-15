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
}
