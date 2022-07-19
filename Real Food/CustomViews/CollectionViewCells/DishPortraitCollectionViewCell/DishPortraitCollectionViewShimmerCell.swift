//
//  DishPortraitCollectionViewShimmerCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 18/07/22.
//

import UIKit

class DishPortraitCollectionViewShimmerCell: UICollectionViewCell {
    private let image: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 10
        return view
    }()
    
    let titleLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 8
        return view
    }()
    
    let priceLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 8
        return view
    }()
    
    let descriptionLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 8
        return view
    }()
    
    func setup() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 10
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 180),
            contentView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            titleLabel.widthAnchor.constraint(equalToConstant: 130),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            image.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            image.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            image.heightAnchor.constraint(equalToConstant: 208),
            
            priceLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),
            priceLabel.heightAnchor.constraint(equalToConstant: 15),
            
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 160),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
