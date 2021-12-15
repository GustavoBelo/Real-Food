//
//  DishPortraitCollectionViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/12/21.
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish) {
        dish.setup(title: titleLbl,
                   imageView: dishImageView,
                   calories: caloriesLbl,
                   description: descriptionLbl)
    }
}
