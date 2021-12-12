//
//  DishPortraitCollectionViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/12/21.
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: DishPortraitCollectionViewCell.self)
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish) {
        titleLbl.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        if dish.calories != nil {
            caloriesLbl.text = dish.formattedCalories
        } else {
            caloriesLbl.isHidden.toggle()
        }
        descriptionLbl.text = dish.description
    }
    
}
