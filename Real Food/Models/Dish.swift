//
//  Dish.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/12/21.
//

import UIKit
import SwiftUI

struct Dish: Equatable {
    struct K {
        static let dish = "dish"
        static let id = "id"
        static let name = "name"
        static let image = "image"
        static let description = "description"
        static let calories = "calories"
    }
    let id, name, image, description: String?
    let calories: Int?
    
    var formattedCalories: String {
        return "\(calories!) calorias"
    }
    
    func setup(title: UILabel,
               imageView: UIImageView,
               calories: UILabel?,
               description: UILabel ) {
        let dish = self
        title.text = dish.name
        imageView.kf.setImage(with: dish.image?.asUrl)
        if dish.calories != nil && dish.calories != 0 {
            calories?.text = dish.formattedCalories
        } else {
            calories?.isHidden.toggle()
        }
        description.text = dish.description
    }
}
