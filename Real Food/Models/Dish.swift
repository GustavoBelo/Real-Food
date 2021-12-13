//
//  Dish.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/12/21.
//

import UIKit
import SwiftUI

struct Dish {
    let id, name, image, description: String?
    let calories: Int?
    
    var formattedCalories: String {
        return "\(calories!) calorias"
    }
    
    func setup(title: UILabel,
               imageView: UIImageView,
               calories: UILabel,
               description: UILabel ) {
        let dish = self
        title.text = dish.name
        imageView.kf.setImage(with: dish.image?.asUrl)
        if dish.calories != nil {
            calories.text = dish.formattedCalories
        } else {
            calories.isHidden.toggle()
        }
        description.text = dish.description
    }
}
