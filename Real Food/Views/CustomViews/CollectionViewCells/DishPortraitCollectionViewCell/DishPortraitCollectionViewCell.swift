//
//  DishPortraitCollectionViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/12/21.
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var dishImageView: UIImageView!
    @IBOutlet private weak var caloriesLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish) {
        dish.setup(title: titleLbl,
                   imageView: dishImageView,
                   calories: caloriesLbl,
                   description: descriptionLbl)
    }
}
