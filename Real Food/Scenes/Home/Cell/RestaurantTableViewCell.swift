//
//  RestaurantTableViewCell.swift
//  Real Food
//
//  Created by Gustavo Belo on 20/04/22.
//

import UIKit

//protocol RestaurantTableViewCellDelegate: UIViewController {
//
//}

class RestaurantTableViewCell: UITableViewCell {
    var restaurantTitle: String?
    private var restaurantBranchName: String?
    private var category: String?
    private var openingHoursString: String?
    private var imageLink: String?
    var restaurantID: String?
    var branchID: String?
    
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
    
    private let imageIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let restaurantTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let restaurantBranch: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let hourView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timeIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "timer")
        icon.tintColor = .black
        icon.clipsToBounds = true
        return icon
    }()
    
    private let openingHours: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    private let categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(imageLink: String, restaurantName: String, restaurantBranch: String, restaurantID: String, branchID: String, category: String, openingHours: String) {
        self.imageLink = imageLink
        self.restaurantTitle = restaurantName
        self.restaurantBranchName = restaurantBranch
        self.restaurantID = restaurantID
        self.branchID = branchID
        self.category = category
        self.openingHoursString = openingHours
        setupComponents()
    }
    
    private func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    private func setupComponents() {
        imageIcon.load(url: URL(string: imageLink ?? Strings.notFoundImage)!)
        
        restaurantTitleLabel.text = restaurantTitle
        restaurantBranch.text = restaurantBranchName
        openingHours.text = openingHoursString
        categoryName.text = category
        
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
            
            restaurantBranch.topAnchor.constraint(equalTo: restaurantTitleLabel.bottomAnchor),
            restaurantBranch.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            
            hourView.topAnchor.constraint(equalTo: restaurantBranch.bottomAnchor, constant: 20),
            hourView.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            
            timeIcon.centerYAnchor.constraint(equalTo: hourView.centerYAnchor),
            timeIcon.leftAnchor.constraint(equalTo: hourView.leftAnchor),
            
            openingHours.centerYAnchor.constraint(equalTo: hourView.centerYAnchor),
            openingHours.leftAnchor.constraint(equalTo: timeIcon.rightAnchor, constant: 10),
            
            categoryName.topAnchor.constraint(equalTo: hourView.bottomAnchor, constant: 15),
            categoryName.leftAnchor.constraint(equalTo: descriptionView.leftAnchor),
            categoryName.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor)
        ])
    }
}
