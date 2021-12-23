//
//  HomeViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 10/12/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet private weak var categoryCollectionView: UICollectionView!
    @IBOutlet private weak var popularCollectionView: UICollectionView!
    @IBOutlet private weak var specialCollectionView: UICollectionView!
    @IBOutlet private weak var logOutOrLoginButton: UIBarButtonItem!
    
    @IBAction private func logOutOrLoginPressed(_ sender: UIBarButtonItem) {
        if Auth.auth().currentUser?.email != nil {
            do {
                try Auth.auth().signOut()
                self.goToInitial()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        } else {
            self.goToInitial()
        }
    }
    @IBAction private func CartPressed(_ sender: UIBarButtonItem) {
        let controller = ListOrdersViewController.instantiate()
        controller.restaurant = restaurant
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private let db = Firestore.firestore()
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "Africa Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 2", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 3", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 4", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 5", image: "https://picsum.photos/100/200")
    ]
    
    private var populars: [Dish] = []
    private var specials: [Dish] = []
    
    var restaurant: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        restaurant = navigationController?.title
        title = restaurant
        loadPopularDishes()
        loadSpecialDishes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Auth.auth().currentUser?.email == nil {
            logOutOrLoginButton.title = "Entrar"
        }
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension HomeViewController {
    private func loadPopularDishes() {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print(e)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    self.addPopularDishes(with: snapshotDocuments)
                }
            }
    }
    
    private func loadSpecialDishes() {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
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
                        let finalDish = Dish(id: newDish[Dish.K.id] as? String,
                                             name: newDish[Dish.K.name] as? String,
                                             image: newDish[Dish.K.image] as? String,
                                             description: newDish[Dish.K.description] as? String,
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
                        let finalDish = Dish(id: newDish[Dish.K.id] as? String,
                                             name: newDish[Dish.K.name] as? String,
                                             image: newDish[Dish.K.image] as? String,
                                             description: newDish[Dish.K.description] as? String,
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
