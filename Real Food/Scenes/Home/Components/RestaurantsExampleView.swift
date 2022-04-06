//
//  RestaurantsExampleView.swift
//  Real Food
//
//  Created by Gustavo Belo on 06/04/22.
//

import UIKit

protocol RestaurantsExampleViewDelegate: AnyObject {
    func showRestaurantsList()
    func showRestaurantsNearby()
}

class RestaurantsExampleView: UIView {
    var title: String
    var seeMoreText: String
    
    init(title: String, seeMoreText: String) {
        self.title = title
        self.seeMoreText = seeMoreText
    
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var seeMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupSpecialText() {
        let attributedText = NSAttributedString(string: seeMoreText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        seeMoreButton.setAttributedTitle(attributedText, for: .normal)
        seeMoreButton.setTitleColor(Theme.specialTextColor, for: .normal)
    }
    
    private func setupElements() {
        titleLabel.text = title
        setupSpecialText()
    }
    
    func setupView() {
        setupElements()
        self.addSubview(titleLabel)
        self.addSubview(seeMoreButton)
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            seeMoreButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            seeMoreButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            seeMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
    }
}
