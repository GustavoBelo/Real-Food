//
//  MenuViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 10/12/21.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var popularCollectionView: UICollectionView!
    @IBOutlet private weak var specialCollectionView: UICollectionView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backButtonMenuPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func CartPressed(_ sender: UIBarButtonItem) {
        let controller = ListOrdersViewController.instantiate()
        controller.restaurant = restaurantID
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private let db = Firestore.firestore()
    
    var restaurantID: String?
    var branchID: String?
    
    private var didLoadCategories = false
    private var didLoadPopulars = false
    private var didLoadSpecials = false
    
    private var viewModel: MenuViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let restaurantID = restaurantID, let branchID = branchID {
            self.viewModel = MenuViewModel(restaurantID: restaurantID, branchID: branchID)
            bindViewModel()
        }
        setupNavigationBar()
        registerCells()
        loadPopularDishes()
        loadSpecialDishes()
        loadCategories()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        backButton.image = UIImage(systemName: "chevron.backward")
    }
    
    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        viewModel.state.bind { [weak self] in
            guard let state = $0 else { return }
            switch state {
            case .categoryData:
                self?.didLoadCategories = true
                DispatchQueue.main.async {
                    self?.categoryCollectionView.reloadData()
                }
            case .popularData:
                self?.didLoadPopulars = true
                DispatchQueue.main.async {
                    self?.popularCollectionView.reloadData()
                }
            case .specialData:
                self?.didLoadSpecials = true
                DispatchQueue.main.async {
                    self?.specialCollectionView.reloadData()
                }
            case .loadingCategoryData:
                print("loadingCategoryData")
            case .loadingPopularData:
                print("loadingPopularData")
            case .loadingSpecialData:
                print("loadingSpecialData")
            case .error(let message):
                print("michael jackson falhou: ", message)
            }
            
        }
    }
    
    private func registerCells() {
        categoryCollectionView.register(CategoryCollectionViewShimmerCell.self, forCellWithReuseIdentifier: CategoryCollectionViewShimmerCell.identifier)
        popularCollectionView.register(DishPortraitCollectionViewShimmerCell.self, forCellWithReuseIdentifier: DishPortraitCollectionViewShimmerCell.identifier)
        specialCollectionView.register(DishLandscapeCollectionViewShimmerCell.self, forCellWithReuseIdentifier: DishLandscapeCollectionViewShimmerCell.identifier)
        
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        switch collectionView {
        case categoryCollectionView:
            if viewModel.state.value == .categoryData {
                return viewModel.categoryArray.count
            }
            return 3
        case popularCollectionView:
            if viewModel.state.value == .popularData {
                return viewModel.popularsArray.count
            }
            return 2
        case specialCollectionView:
            if viewModel.state.value == .specialData {
                return viewModel.specialsArray.count
            }
            return 2
        default: return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        switch collectionView {
        case categoryCollectionView:
            if didLoadCategories {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
                cell.setup(category: viewModel.categoryArray[indexPath.row])
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewShimmerCell.identifier, for: indexPath) as! CategoryCollectionViewShimmerCell
            cell.setup()
            return cell
        case popularCollectionView:
            if didLoadPopulars {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
                cell.setup(dish: viewModel.popularsArray[indexPath.row])
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewShimmerCell.identifier, for: indexPath) as! DishPortraitCollectionViewShimmerCell
            cell.setup()
            return cell
        case specialCollectionView:
            if didLoadSpecials {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
                cell.setup(dish: viewModel.specialsArray[indexPath.row])
                return cell
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewShimmerCell.identifier, for: indexPath) as! DishLandscapeCollectionViewShimmerCell
            cell.setup()
            return cell 
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if collectionView == categoryCollectionView {
            let controller = ListDishesViewController.instantiate()
            controller.restaurant = restaurantID
            controller.category = viewModel.categoryArray[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = DishDetailViewController.instantiate()
            controller.restaurant = restaurantID
            controller.dish = collectionView == popularCollectionView ? viewModel.popularsArray[indexPath.row] : viewModel.specialsArray[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension MenuViewController {
    private func loadPopularDishes() {
        guard let viewModel = self.viewModel else { return }
        viewModel.loadPopulars()
    }
    
    private func loadCategories() {
        guard let viewModel = self.viewModel else { return }
        viewModel.loadCategories()
    }
    
    private func loadSpecialDishes() {
        guard let viewModel = self.viewModel else { return }
        viewModel.loadSpecials()
    }
}
