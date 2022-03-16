//
//  BaseTableViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 11/03/22.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    var cellIndex = Int()

    var cellStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 16
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    var cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    var cellIcon: UIButton = {
        let icon = UIButton()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    var loadingView: UIActivityIndicatorView = {
       let loadingView = UIActivityIndicatorView()
        loadingView.color = .gray
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = .white
        loadingView.startAnimating()
        loadingView.backgroundColor = .clear
        return loadingView
    }()
    
    func setupCell(icon: String, title: String, at cellIndex: Int) {
        self.cellIndex = cellIndex
        setupView()
        cellLabel.text = title
        cellIcon.setImage(UIImage(systemName: icon), for: .normal)
    }
    
    func setupView() {
        // must be override
    }

}
