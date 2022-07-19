//
//  HomeView.swift
//  Real Food
//
//  Created by Gustavo Belo on 04/04/22.
//

import UIKit

class HomeView: BaseView {
    
    weak var delegate: HomeViewController?
    
    var restaurantViewModel: RestaurantsViewModel
    
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
    
    var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupView()
        
        return view
    }()
    
    lazy var restaurantsExampleView: RestaurantsExampleView =  {
        let view = RestaurantsExampleView(title: Strings.Home.restaurantsExampleView.title,
                                          seeMoreText: Strings.Home.restaurantsExampleView.seeMoreText,
                                          viewModel: self.restaurantViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupView()
        return view
    }()
    
    init(restaurantViewModel: RestaurantsViewModel) {
        self.restaurantViewModel = restaurantViewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        self.backgroundColor = Theme.backgroundColor
        setupTableHeaderView()
        setupComponents()
        addSubviews()
    }
    
    private func setupComponents() {
        restaurantsExampleView.delegate = self
        restaurantsExampleView.seeMoreButton.addTarget(self, action: #selector(showRestaurantsList), for: .touchUpInside)
    }
    
    private func setupTableHeaderView() {
        headerView.delegate = self
        setTitle(text: Strings.Home.title)
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(headerView)
        
        scrollView.addSubview(contentView)
        scrollView.addSubview(restaurantsExampleView)
        self.addSubview(scrollView)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            headerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            headerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            restaurantsExampleView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            restaurantsExampleView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            restaurantsExampleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            restaurantsExampleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
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

extension HomeView: RestaurantsExampleViewDelegate {
    @objc
    func showRestaurantsList() {
        delegate?.showRestaurantsList()
    }
    
    func showRestaurantsNearby() {
        delegate?.showRestaurantsNearby()
    }
    
    func openRestaurantMenu(restaurantID: String, branchID: String) {
        delegate?.openRestaurantMenu(restaurantID: restaurantID, branchID: branchID)
    }
}
