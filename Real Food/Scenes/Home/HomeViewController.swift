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
    
    private let homeView: HomeView = {
       return HomeView()
    }()
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

