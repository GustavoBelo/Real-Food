//
//  RestaurantsExampleView.swift
//  Real Food
//
//  Created by Gustavo Belo on 06/04/22.
//

import UIKit
import Firebase

protocol RestaurantsExampleViewDelegate: AnyObject {
    func showRestaurantsList()
    func showRestaurantsNearby()
    func openRestaurantMenu(restaurantID: String, branchID: String)
}

class RestaurantsExampleView: UIView {
    var title: String
    var seeMoreText: String
    
    weak var delegate: RestaurantsExampleViewDelegate?
    var viewModel: RestaurantsViewModel
    
    init(title: String, seeMoreText: String, viewModel: RestaurantsViewModel) {
        self.title = title
        self.seeMoreText = seeMoreText
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var seeMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupSpecialText() {
        let attributedText = NSAttributedString(string: seeMoreText, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        seeMoreButton.setAttributedTitle(attributedText, for: .normal)
        seeMoreButton.setTitleColor(Theme.specialTextColor, for: .normal)
    }
    
    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cardsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private func setupElements() {
        titleLabel.text = title
        setupSpecialText()
    }
    
    func setupView() {
        viewModel.setupCellsData()
        setupElements()
        addSubviews()
        setupTableView()
        setupConstraints()
    }
    
    private func setupTableView() {
        cardsTableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        cardsTableView.register(RestaurantTableViewShimmerCell.self, forCellReuseIdentifier: RestaurantTableViewShimmerCell.identifier)
        
        cardsTableView.dataSource = self
        cardsTableView.delegate = self
        
    }
    
    private func addSubviews() {
        self.addSubview(cardsTableView)
        cardsTableView.tableHeaderView = headerView
        cardsTableView.tableFooterView = UIView()
        
        headerView.addSubview(titleLabel)
        headerView.addSubview(seeMoreButton)
        
    }
    
    private func setupConstraints() {
        cardsTableView.bindEdgesToSuperview()
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            
            seeMoreButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            seeMoreButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -70),
            seeMoreButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        cardsTableView.layoutIfNeeded()
    }
}

extension RestaurantsExampleView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel.cellType.value == .dataCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier) as? RestaurantTableViewCell
            
            var strings = [String() : String()]
            strings.updateValue(self.viewModel.restaurantsCellsData[indexPath.row]![Restaurants.Document.name]!, forKey: Restaurants.Document.name)
            strings.updateValue(self.viewModel.restaurantsCellsData[indexPath.row]![Restaurants.Document.Branches.identifier]!, forKey: Restaurants.Document.Branches.identifier)
            strings.updateValue(self.viewModel.restaurantsCellsData[indexPath.row]![Restaurants.id]!, forKey: Restaurants.id)
            strings.updateValue(self.viewModel.restaurantsCellsData[indexPath.row]![Restaurants.Document.Branches.id]!, forKey: Restaurants.Document.Branches.id)
            strings.updateValue(self.viewModel.restaurantsCellsData[indexPath.row]![Restaurants.Document.Branches.Document.Days.openingHours]!, forKey: Restaurants.Document.Branches.Document.Days.openingHours)
            strings.updateValue(self.viewModel.restaurantsCellsData[indexPath.row]![Restaurants.category]!, forKey: Restaurants.category)
            strings.updateValue(self.viewModel.restaurantsCellsData[indexPath.row]![Restaurants.image]!, forKey: Restaurants.image)
            
            cell?.setupCell(imageLink: strings[Restaurants.image]!,
                            restaurantName: strings[Restaurants.Document.name]!,
                            restaurantBranch: strings[Restaurants.Document.Branches.identifier]!,
                            restaurantID: strings[Restaurants.id]!,
                            branchID: strings[Restaurants.Document.Branches.id]!,
                            category: strings[Restaurants.category]!,
                            openingHours: strings[Restaurants.Document.Branches.Document.Days.openingHours]!)
            return cell ?? UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewShimmerCell.identifier) as? RestaurantTableViewShimmerCell
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell,
              let restaurantID = cell.restaurantID,
              let branchID = cell.branchID,
              let delegate = self.delegate
        else { return }
        delegate.openRestaurantMenu(restaurantID: restaurantID, branchID: branchID)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
