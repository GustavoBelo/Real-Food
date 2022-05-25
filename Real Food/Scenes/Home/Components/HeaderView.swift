//
//  HeaderView.swift
//  Real Food
//
//  Created by Gustavo Belo on 06/04/22.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func openScannerView()
    func openSearchRestaurant()
}

class HeaderView: UIView {
    var delegate: HeaderViewDelegate?
    
    private struct Strings {
        static let title: String = "O que temos para hoje?"
        static let qrCodeIcon = "qrcode"
        static let qrCodeText = "QRCode"
        
        static let searchRestaurantsIcon = "magnifyingglass"
        static let searchRestaurantsText = "Buscar restautante"
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 11
        return stackView
    }()
    
    private var qrCodeButton: HeaderViewButton = {
        let view = HeaderViewButton(title: Strings.qrCodeText, icon: Strings.qrCodeIcon)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupView()
        view.backgroundColor = Theme.componentForegroundColor
        view.cornerRadius = 10
        
        return view
    }()
    
    private var searchRestaurantButton: HeaderViewButton = {
        let view = HeaderViewButton(title: Strings.searchRestaurantsText, icon: Strings.searchRestaurantsIcon)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupView()
        view.backgroundColor = Theme.componentForegroundColor
        view.cornerRadius = 10
        
        return view
    }()
    
    private func setupElements() {
        let tapGoToQRCode = UITapGestureRecognizer(target: self, action: #selector(didPressQRCode))
        qrCodeButton.addGestureRecognizer(tapGoToQRCode)
        
    }
    
    func setupView() {
        setupElements()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        self.addSubview(titleLabel)
        
        buttonsStackView.addArrangedSubview(qrCodeButton)
        buttonsStackView.addArrangedSubview(searchRestaurantButton)
        self.addSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            buttonsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60),
            buttonsStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            buttonsStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            buttonsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc
    func didPressQRCode() {
        delegate?.openScannerView()
    }
}
