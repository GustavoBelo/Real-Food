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
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var qrCodeButton: UIView = {
        let view = HeaderViewButton(title: Strings.qrCodeText, icon: Strings.qrCodeIcon)
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
        self.addSubview(titleLabel)
        self.addSubview(qrCodeButton)
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            qrCodeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            qrCodeButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            qrCodeButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            qrCodeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
    }
    
    @objc
    func didPressQRCode() {
        delegate?.openScannerView()
    }
}
