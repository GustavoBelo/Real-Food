//
//  Dish.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/12/21.
//

import Foundation

struct Dish {
    let id, name, image, description: String?
    let calories: Int?
    
    var formattedCalories: String {
        return "\(calories!) calorias"
    }
}
