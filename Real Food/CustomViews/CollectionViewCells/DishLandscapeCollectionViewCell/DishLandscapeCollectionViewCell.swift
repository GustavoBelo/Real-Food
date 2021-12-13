//
//  DishLandscapeCollectionViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 13/12/21.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: DishLandscapeCollectionViewCell.self)
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    
    func setup(dish: Dish) {
        dish.setup(title: titleLbl,
                   imageView: dishImageView,
                   calories: caloriesLbl,
                   description: descriptionLbl)
    }

}
