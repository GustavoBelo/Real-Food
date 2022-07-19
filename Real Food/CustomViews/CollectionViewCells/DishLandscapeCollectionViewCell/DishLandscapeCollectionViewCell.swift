//
//  DishLandscapeCollectionViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 13/12/21.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var dishImageView: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    @IBOutlet private weak var priceLbl: UILabel!
    
    func setup(dish: Dish) {
        dish.setup(title: titleLbl,
                   imageView: dishImageView,
                   price: priceLbl,
                   description: descriptionLbl)
    }
    
}
