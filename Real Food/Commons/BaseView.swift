//
//  BaseView.swift
//  Real Food
//
//  Created by Gustavo Belo on 04/04/22.
//

import UIKit

class BaseView: UIView {
    // MARK: - Properties
    private static let navBarTitleFont = UIFont.systemFont(ofSize: 24)
    private static let sectionTitleFont = UIFont.systemFont(ofSize: 16)
    
    static let iPhone5Height: CGFloat = 1136
    
    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        // needs to be overriten
    }
    
    func setupConstraints() {
        // needs to be overriten
    }
    
    // MARK: - setup and create views
    func setTitle(text: String) {
        titleLabel.text = text
        titleLabel.accessibilityLabel = text
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.font = BaseView.navBarTitleFont
        return label
    }()
    
}
