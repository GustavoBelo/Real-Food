//
//  BaseViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 04/04/22.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Constructors
    init() {
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Setup View
    func bindViewModel() {
        // needs to be overriten
    }
    
    func setupView() {
        // needs to be overriten
    }
    
    func setupConstraints() {
        // needs to be overriten
    }
    
    // MARK: - Setup Navigation
    func setupNavigationController() {
        self.extendedLayoutIncludesOpaqueBars = true
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.barTintColor = .white
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonItem
    }
    
    private var backButton: UILabel {
        let backButton =  UILabel()
        let icon = UIImage(systemName: "chevron.backward")
        let attachment = NSTextAttachment()
        let attributedString = NSMutableAttributedString()
        
        backButton.accessibilityLabel = "voltar"
        backButton.accessibilityTraits = .button
        backButton.isUserInteractionEnabled = true
        
        attachment.image = icon
        attributedString.append(NSAttributedString(attachment: attachment))
        
        let tapBackButton = UITapGestureRecognizer(target: self, action: #selector(didPressBackButton))
        backButton.addGestureRecognizer(tapBackButton)
        return backButton
    }
    
    @objc
    func didPressBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
