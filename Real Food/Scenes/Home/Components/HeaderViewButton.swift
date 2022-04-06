//
//  HeaderViewButton.swift
//  Real Food
//
//  Created by Gustavo Belo on 06/04/22.
//

import UIKit

class HeaderViewButton: UIView {
    
    var title: String
    var icon: String
    
    init(title: String, icon: String) {
        self.title = title
        self.icon = icon
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var componentIcon: UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let iconImage = UIImage(systemName: icon, withConfiguration: largeConfig)
        button.setImage(iconImage, for: .normal)
        return button
    }()
    
    private lazy var componentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        return label
    }()
    
    private lazy var component: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.accessibilityLabel = title
        view.accessibilityTraits = .button
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    func setupView() {
        component.addSubview(componentIcon)
        component.addSubview(componentLabel)
        self.addSubview(component)
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: self.topAnchor),
            component.leftAnchor.constraint(equalTo: self.leftAnchor),
            component.rightAnchor.constraint(equalTo: self.rightAnchor),
            component.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            componentIcon.topAnchor.constraint(equalTo: component.topAnchor, constant: 10),
            componentIcon.leftAnchor.constraint(equalTo: component.leftAnchor, constant: 10),
            
            componentLabel.centerYAnchor.constraint(equalTo: componentIcon.centerYAnchor),
            componentLabel.leftAnchor.constraint(equalTo: componentIcon.rightAnchor, constant: 10),
            componentLabel.bottomAnchor.constraint(equalTo: component.bottomAnchor, constant: -13),
        
        ])
    }
}
