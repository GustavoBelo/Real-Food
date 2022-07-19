//
//  RestaurantTableViewShimmerCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 24/05/22.
//

import UIKit
import SwiftUI

class RestaurantTableViewShimmerCell: UITableViewCell {
    
    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.componentForegroundColor
        view.cornerRadius = 10
        return view
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageIcon: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 10
        return view
    }()
    
    let restaurantTitleLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 8
        return view
    }()
    
    private let restaurantBranch: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 6
        return view
    }()
    
    private let hourView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeIcon: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private let openingHours: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 5
        return view
    }()
    
    private let categoryName: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.shimmerForegroundColor
        view.cornerRadius = 5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupComponents()
    }
    
    private func setupComponents() {
    }
    
    private func addSubviews() {
        hourView.addSubview(timeIcon)
        hourView.addSubview(openingHours)
        
        descriptionView.addSubview(restaurantTitleLabel)
        descriptionView.addSubview(restaurantBranch)
        descriptionView.addSubview(hourView)
        descriptionView.addSubview(categoryName)
        
        content.addSubview(imageIcon)
        content.addSubview(descriptionView)
        
        self.addSubview(content)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            content.leftAnchor.constraint(equalTo: self.leftAnchor),
            content.rightAnchor.constraint(equalTo: self.rightAnchor),
            content.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
            
            imageIcon.centerYAnchor.constraint(equalTo: content.centerYAnchor),
            imageIcon.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 19),
            imageIcon.widthAnchor.constraint(equalToConstant: 92),
            imageIcon.heightAnchor.constraint(equalToConstant: 75),
            
            descriptionView.centerYAnchor.constraint(equalTo: content.centerYAnchor),
            descriptionView.leftAnchor.constraint(equalTo: imageIcon.rightAnchor, constant: 22),
            descriptionView.rightAnchor.constraint(equalTo: content.rightAnchor),
            
            restaurantTitleLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: -15),
            restaurantTitleLabel.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            restaurantTitleLabel.widthAnchor.constraint(equalToConstant: 190),
            restaurantTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            
            restaurantBranch.topAnchor.constraint(equalTo: restaurantTitleLabel.bottomAnchor, constant: 5),
            restaurantBranch.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            restaurantBranch.widthAnchor.constraint(equalToConstant: 170),
            restaurantBranch.heightAnchor.constraint(equalToConstant: 10),
            
            hourView.topAnchor.constraint(equalTo: restaurantBranch.bottomAnchor, constant: 20),
            hourView.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            
            timeIcon.centerYAnchor.constraint(equalTo: hourView.centerYAnchor),
            timeIcon.leftAnchor.constraint(equalTo: hourView.leftAnchor),
            timeIcon.widthAnchor.constraint(equalToConstant: 20),
            timeIcon.heightAnchor.constraint(equalToConstant: 20),
            
            openingHours.centerYAnchor.constraint(equalTo: hourView.centerYAnchor),
            openingHours.leftAnchor.constraint(equalTo: timeIcon.rightAnchor, constant: 10),
            openingHours.widthAnchor.constraint(equalToConstant: 100),
            openingHours.heightAnchor.constraint(equalToConstant: 10),
            
            categoryName.topAnchor.constraint(equalTo: hourView.bottomAnchor, constant: 15),
            categoryName.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            categoryName.widthAnchor.constraint(equalToConstant: 80),
            categoryName.heightAnchor.constraint(equalToConstant: 8),
            categoryName.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor)
        ])
    }
}
