//
//  HomeView.swift
//  Real Food
//
//  Created by Gustavo Belo on 04/04/22.
//

import UIKit

class HomeView: BaseView, RestaurantsExampleViewDelegate {
    
    weak var delegate: HomeViewController?
    
    struct Strings {
        static let title = "Real Food"
        
        struct restaurantsExampleView {
            static let title = "Restaurantes"
            static let seeMoreText = "ver todos"
        }
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupView()
        view.delegate = self
        
        return view
    }()
    
    lazy var restaurantsExampleView: RestaurantsExampleView =  {
        let view = RestaurantsExampleView(title: Strings.restaurantsExampleView.title, seeMoreText: Strings.restaurantsExampleView.seeMoreText)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupView()
        view.seeMoreButton.addTarget(self, action: #selector(showRestaurantsList), for: .touchUpInside)
        return view
    }()

    override func setupView() {
        self.backgroundColor = Theme.backgroundColor
        setTableHeaderView()
        addSubviews()
    }
    
    private func setTableHeaderView() {
        setTitle(text: Strings.title)
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(headerView)
        
        contentView.addSubview(restaurantsExampleView)
        scrollView.addSubview(contentView)
        self.addSubview(scrollView)
        restaurantsExampleView.isHidden = true// michael jackson
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            headerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            headerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            restaurantsExampleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            restaurantsExampleView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            restaurantsExampleView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            restaurantsExampleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    @objc
    func showRestaurantsList() {
        delegate?.showRestaurantsList()
    }
    
    func showRestaurantsNearby() {
        delegate?.showRestaurantsNearby()
    }
}

extension HomeView: HeaderViewDelegate {
    func openScannerView() {
        delegate?.openScannerView()
    }
    
    func openSearchRestaurant() {
        delegate?.openSearchRestaurant()
    }    
}
