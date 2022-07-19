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
        static let identifier = "Dishes"
        static let dish = "dish"
        static let id = "id"
        static let name = "name"
        static let image = "image"
        static let description = "description"
        static let ARModel = "ARModel"
        static let price = "price"
    }
    let id, name, description, ARModel, price: String?
    let image: String
    
    func setup(title: UILabel,
               imageView: UIImageView,
               price: UILabel?,
               description: UILabel ) {
        let dish = self
        title.text = dish.name
        imageView.load(url: URL(string: dish.image)!)
        if dish.price != "0" {
            price?.text = "R$ \(dish.price!)"
        } else {
            price?.isHidden.toggle()
        }
        description.text = dish.description
    }
}
