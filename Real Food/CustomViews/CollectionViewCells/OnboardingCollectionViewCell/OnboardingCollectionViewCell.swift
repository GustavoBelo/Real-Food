//
//  OnboardingCollectionViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 09/12/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var slideImageView: UIImageView!
    @IBOutlet private weak var slideTitleLabel: UILabel!
    @IBOutlet private weak var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
