//
//  HomeViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 06/04/22.
//

import UIKit
import Firebase
import AVFoundation

class HomeViewController: BaseViewController {
    private var scanner: Scanner?
    private var restaurantViewModel: RestaurantsViewModel
    
    init(restaurantViewModel: RestaurantsViewModel) {
        self.restaurantViewModel = restaurantViewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
    }
    
    override func setupNavigationController() {
        super.setupNavigationController()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func setupView() {
        homeView.delegate = self
        view = homeView
    }
    
    private lazy var homeView: HomeView = {
        return HomeView(restaurantViewModel: self.restaurantViewModel)
    }()
    
    override func bindViewModel() {
        restaurantViewModel.state.bind { [weak self] in
            guard let state = $0 else { return }
            switch state {
            case .data:
                self?.restaurantViewModel.cellType.value = .dataCell
                self?.homeView.restaurantsExampleView.cardsTableView.reloadData()
            case .loading:
                self?.restaurantViewModel.cellType.value = .shimmerCell
                self?.homeView.restaurantsExampleView.cardsTableView.reloadData()
            case .error(_):
                return
            }
        }
    }
}


extension HomeViewController: RestaurantsExampleViewDelegate {
    func showRestaurantsList() {
        print("ver todos michael jackson")
    }
    
    func showRestaurantsNearby() {
        print("ver todos próximos michael jackson")
    }
}

extension HomeViewController: HeaderViewDelegate {
    func openScannerView() {
        //        print("michael", navigationController)
        let vc = CatchRestaurantNameViewController.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSearchRestaurant() {
        //        delegate?.openSearchRestaurant()
    }
    
    func openRestaurantMenu(name: String) {
        let controller = MenuViewController.instantiate()
        navigationController?.title = name
        navigationController?.pushViewController(controller, animated: true)
    }
}

