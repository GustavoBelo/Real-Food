//
//  DishCategory.swift
//  Real Food
//
//  Created by Gustavo Belo on 10/12/21.
//

import Foundation

struct DishCategory {
    struct K {
        static let dishes = "dishes"
        static let id = "id"
        static let name = "name"
        static let image = "image"
    }
    let id, name, image: String?
    let dishes: [String?]
}
