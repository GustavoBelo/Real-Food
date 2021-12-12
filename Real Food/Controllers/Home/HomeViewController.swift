//
//  HomeViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 10/12/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "Africa Dish", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 2", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 3", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 4", image: "https://picsum.photos/100/200"),
        .init(id: "id1", name: "Africa Dish 5", image: "https://picsum.photos/100/200")
    ]
    
    var populars: [Dish] = [
        Dish(id: "id1", name: "Garri", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: nil),
        Dish(id: "id1", name: "Indomie", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: 34),
        Dish(id: "id1", name: "Pizza", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: 34)        
    ]
    
    static let identifier = String(describing: HomeViewController.self)
    var restaurant: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        restaurant = navigationController?.title
        title = restaurant
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return populars.count
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
        default: return UICollectionViewCell()
        }
    }
    
    
}
