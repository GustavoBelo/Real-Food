//
//  HomeViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 10/12/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialCollectionView: UICollectionView!
    @IBOutlet weak var logOutOrLoginButton: UIBarButtonItem!
    
    @IBAction func logOutOrLoginPressed(_ sender: UIBarButtonItem) {
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
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "Africa Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 2", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 3", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 4", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 5", image: "https://picsum.photos/100/200")
    ]
    
    var populars: [Dish] = [
        .init(id: "id1", name: "Garri", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: nil),
        .init(id: "id1", name: "Indomie", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: 34),
        .init(id: "id1", name: "Pizza", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: 34)
    ]
    
    var specials: [Dish] = [
        .init(id: "id1", name: "Fried Plan", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: 34),
        .init(id: "id1", name: "Beans and Garri", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted, This is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tasted" , calories: 34),
        .init(id: "id1", name: "Feijoada", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: nil)
    ]
    var restaurant: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        restaurant = navigationController?.title
        title = restaurant
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
