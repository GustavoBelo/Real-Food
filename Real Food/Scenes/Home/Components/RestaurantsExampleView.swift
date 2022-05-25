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
    func openRestaurantMenu(name: String)
}

class RestaurantsExampleView: UIView {
    var title: String
    var seeMoreText: String
    
    weak var delegate: RestaurantsExampleViewDelegate?
    
    private let db = Firestore.firestore()
    
    var restaurantsCellsData = [String() : String()]
    
    init(title: String, seeMoreText: String) {
        self.title = title
        self.seeMoreText = seeMoreText
        
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
    
    private var cardsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private func setupElements() { // michael jackson fazer aqui
        titleLabel.text = title
        setupSpecialText()
    }
    
    func setupView() {
        setupCells() // vou ter que fazer o bind e o shemmer pra ca
        setupElements()
        addSubviews()
        setupTableView()
        setupConstraints()
    }
    
    private func setupTableView() {
        //michael jackson restaurant
        cardsTableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.cellId)
        
//        cardsTableView.register(ShimmerRestaurantTableViewCell.self, forCellReuseIdentifier: ShimmerRestaurantTableViewCell.cellId)
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
    private func setupCells() {
        db.collection(Restaurants.identifierGroup).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.restaurantsCellsData.updateValue(document.documentID, forKey: Restaurants.name)
                    print("michael jackson\(document.documentID)")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.cellId) as? RestaurantTableViewCell
        var titles = [String]()
                for (key, value) in self.restaurantsCellsData {
                    titles.append(value)
                }
                print(self.restaurantsCellsData, "dict")

        print("michael", title)
        cell?.setupCell(restaurantName: "Vivenda do camarão", restaurantBranch: "Shopping ABC", category: "Frutos do mar", openingHours: "10:00 - 23:00")
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: ShimmerRestaurantTableViewCell.cellId) as? ShimmerRestaurantTableViewCell
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.cellId) as? RestaurantTableViewCell
        let restaurantName = cell?.restaurantTitleLabel.text ?? "Vivenda do camarão"
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.openRestaurantMenu(name: restaurantName)
    }
}
