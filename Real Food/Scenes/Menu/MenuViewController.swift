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
        controller.restaurant = restaurant
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private let db = Firestore.firestore()
    
    var categories: [DishCategory] = []
    
    private var populars: [Dish] = []
    private var specials: [Dish] = []
    
    var restaurant: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerCells()
        restaurant = navigationController?.title
        title = restaurant
        print(title)
        loadPopularDishes()
        loadSpecialDishes()
        loadCategories()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        backButton.image = UIImage(systemName: "chevron.backward")
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
        case specialCollectionView:
            return specials.count
        default: return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
            cell.setup(dish: populars[indexPath.row])
            return cell
        case specialCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
            cell.setup(dish: specials[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = ListDishesViewController.instantiate()
            controller.restaurant = restaurant
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = DishDetailViewController.instantiate()
            controller.restaurant = restaurant
            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension MenuViewController {
    private func loadPopularDishes() {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                self.populars = []
                if let e = error {
                    print(e)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    self.addPopularDishes(with: snapshotDocuments)
                }
            }
    }
    
    private func loadCategories() {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                self.categories = []
                if let e = error {
                    print(e)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    self.addCategories(with: snapshotDocuments)
                }
            }
    }
    
    private func addCategories(with snapshotDocuments: [QueryDocumentSnapshot]) {
        for doc in snapshotDocuments {
            let data = doc.data()
            let restaurant = doc.documentID
            if self.restaurant == restaurant {
                guard let categories = data[Restaurants.categories] as? [String : Any] else { return }
                for category in categories  {
                    guard let fullCategory = category.value as? [String : Any] else { return }
                    let newCategory = DishCategory(id: fullCategory[DishCategory.K.id] as? String,
                                                   name: fullCategory[DishCategory.K.name] as? String,
                                                   image: fullCategory[DishCategory.K.image] as? String,
                                                   dishes: fullCategory[DishCategory.K.dishes] as! [String])
                    
                    
                    self.categories.append(newCategory)
                    DispatchQueue.main.async {
                        self.categoryCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    private func loadSpecialDishes() {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                self.specials = []
                if let e = error {
                    print(e)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    self.addSpecialDishes(with: snapshotDocuments)
                }
            }
    }
    
    private func addPopularDishes(with snapshotDocuments: [QueryDocumentSnapshot]) {
        for doc in snapshotDocuments {
            let data = doc.data()
            let restaurant = doc.documentID
            if self.restaurant == restaurant {
                let category = data[Restaurants.populars] as! [String]
                guard let dishes = data[Restaurants.dishes] as? [String : Any] else { return }
                
                for dish in dishes {
                    if category.contains(dish.key) {
                        guard let newDish = dish.value as? [String : Any] else { return }
                        let finalDish = Dish(id: dish.key,
                                             name: newDish[Dish.K.name] as? String,
                                             image: newDish[Dish.K.image] as? String,
                                             description: newDish[Dish.K.description] as? String,
                                             ARModel: newDish[Dish.K.ARModel] as? String,
                                             calories: newDish[Dish.K.calories] as? Int ?? 0)
                        
                        self.populars.append(finalDish)
                        DispatchQueue.main.async {
                            self.popularCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    private func addSpecialDishes(with snapshotDocuments: [QueryDocumentSnapshot]) {
        for doc in snapshotDocuments {
            let data = doc.data()
            let restaurant = doc.documentID
            if self.restaurant == restaurant {
                let category = data[Restaurants.specials] as! [String]
                guard let dishes = data[Restaurants.dishes] as? [String : Any] else { return }
                
                for dish in dishes {
                    if category.contains(dish.key) {
                        guard let newDish = dish.value as? [String : Any] else { return }
                        let finalDish = Dish(id: dish.key,
                                             name: newDish[Dish.K.name] as? String,
                                             image: newDish[Dish.K.image] as? String,
                                             description: newDish[Dish.K.description] as? String,
                                             ARModel: newDish[Dish.K.ARModel] as? String,
                                             calories: newDish[Dish.K.calories] as? Int ?? 0)
                        
                        self.specials.append(finalDish)
                        DispatchQueue.main.async {
                            self.specialCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
}