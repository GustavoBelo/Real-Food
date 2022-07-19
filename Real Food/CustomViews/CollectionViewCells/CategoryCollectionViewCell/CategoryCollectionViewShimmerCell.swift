//
//  CategoryCollectionViewShimmerCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 16/07/22.
//

import UIKit

class CategoryCollectionViewShimmerCell: UICollectionViewCell {
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
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 150),
            contentView.heightAnchor.constraint(equalToConstant: 56),
            
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            image.widthAnchor.constraint(equalToConstant: 40),
            image.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 60),
            titleLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
