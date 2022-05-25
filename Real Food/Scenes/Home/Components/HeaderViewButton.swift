//
//  HeaderViewButton.swift
//  Real Food
//
//  Created by Gustavo Belo on 06/04/22.
//

import UIKit

class HeaderViewButton: UIView {
    var isIPhone5: Bool = false
    
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
    
    private var componentIcon: UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var componentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private var component: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupView() {
        setupComponents()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        component.addSubview(componentIcon)
        component.addSubview(componentLabel)
        self.addSubview(component)
    }
    
    private func setupComponents() {
        var titleFontSize: CGFloat = 16
        var iconPointSize: CGFloat = 20
        if UIScreen.main.nativeBounds.height == BaseView.iPhone5Height {
            isIPhone5 = true
            titleFontSize = 15
            iconPointSize = 16
        }
        componentLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        componentLabel.text = title
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: iconPointSize, weight: .regular, scale: .large)
        let iconImage = UIImage(systemName: icon, withConfiguration: largeConfig)
        
        componentIcon.setImage(iconImage, for: .normal)
        componentIcon.tintColor = .black
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            component.topAnchor.constraint(equalTo: self.topAnchor),
            component.leftAnchor.constraint(equalTo: self.leftAnchor),
            component.rightAnchor.constraint(equalTo: self.rightAnchor),
            component.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            componentIcon.centerYAnchor.constraint(equalTo: component.centerYAnchor),
            componentIcon.leftAnchor.constraint(equalTo: component.leftAnchor, constant: isIPhone5 ? 5 : 10),
            componentIcon.widthAnchor.constraint(equalToConstant: 30),
            
            componentLabel.centerYAnchor.constraint(equalTo: componentIcon.centerYAnchor),
            componentLabel.leftAnchor.constraint(equalTo: componentIcon.rightAnchor, constant: isIPhone5 ? 5 : 10),
            componentLabel.rightAnchor.constraint(equalTo: component.rightAnchor)
            
        ])
    }
}
