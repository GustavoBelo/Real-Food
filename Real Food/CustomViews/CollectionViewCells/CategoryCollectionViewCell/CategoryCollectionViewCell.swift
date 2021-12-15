//
//  CategoryCollectionViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 10/12/21.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    
    func setup(category: DishCategory) {
        categoryTitleLbl.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asUrl)
    }

}
