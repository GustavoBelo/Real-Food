//
//  UserMenuTableViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 09/03/22.
//

import UIKit

class UserMenuTableViewCell: BaseTableViewCell {
    var delegate: UserMenuViewController!
    
    override func setupView() {
        super.setupView()
        contentView.addSubview(loadingView)
        contentView.addSubview(cellStackView)
        cellStackView.addSubview(cellIcon)
        cellStackView.addSubview(cellLabel)
        setupConstraints()
        
        loadingView.isHidden = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cellStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            cellStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            cellIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellIcon.leftAnchor.constraint(equalTo: cellStackView.leftAnchor, constant: -15),
            cellIcon.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.12),
            
            cellLabel.centerYAnchor.constraint(equalTo: cellIcon.centerYAnchor),
            cellLabel.leftAnchor.constraint(equalTo: cellIcon.rightAnchor),
            
            loadingView.centerYAnchor.constraint(equalTo: cellIcon.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: cellIcon.centerXAnchor)
        ])
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
