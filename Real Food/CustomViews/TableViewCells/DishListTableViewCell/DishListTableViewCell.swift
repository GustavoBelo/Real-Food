//
//  DishListTableViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 14/12/21.
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish) {
        dish.setup(title: titleLbl, imageView: dishImageView, calories: nil, description: descriptionLbl)
    }
    
}
