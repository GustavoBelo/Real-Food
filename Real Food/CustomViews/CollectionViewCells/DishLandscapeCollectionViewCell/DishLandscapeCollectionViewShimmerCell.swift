//
//  DishLandscapeCollectionViewShimmerCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 18/07/22.
//

import UIKit

class DishLandscapeCollectionViewShimmerCell: UICollectionViewCell {
    private let image: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 10
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 16
        view.contentMode = .scaleToFill
        view.distribution = .fill
        view.axis = .vertical
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
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(descriptionLabel)
        contentView.addSubview(image)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 330),
            contentView.heightAnchor.constraint(equalToConstant: 100),
            
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 68),
            image.heightAnchor.constraint(equalToConstant: 68),
            
            stackView.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 13),
            priceLabel.heightAnchor.constraint(equalToConstant: 10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 10),
        ])
    }
}
