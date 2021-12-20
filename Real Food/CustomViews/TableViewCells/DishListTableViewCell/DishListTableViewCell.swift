//
//  DishListTableViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 14/12/21.
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    @IBOutlet private weak var dishImageView: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish) {
        dish.setup(title: titleLbl,
                   imageView: dishImageView,
                   calories: nil,
                   description: descriptionLbl)
    }
    
    func setup(order: Order) {
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        titleLbl.text = order.dish?.name
        descriptionLbl.text = order.name
    }
}
