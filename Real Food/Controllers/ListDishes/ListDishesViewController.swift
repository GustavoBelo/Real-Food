//
//  ListDishesViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 14/12/21.
//

import UIKit
import Firebase

class ListDishesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let db = Firestore.firestore()
    
    var category: DishCategory!
    var restaurant: String!
    var dishes: [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCells()
        loadDishes()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
}

extension ListDishesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setup(dish: dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
        controller.restaurant = restaurant
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ListDishesViewController {
    private func loadDishes() {
        db.collection(Restaurants.identifierGroup)
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print(e)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    self.addDishes(with: snapshotDocuments)
                }
            }
    }
    
    private func addDishes(with snapshotDocuments: [QueryDocumentSnapshot]) {
        for doc in snapshotDocuments {
            let data = doc.data()
            let restaurant = doc.documentID
            if self.restaurant == restaurant {
                guard let dishes = data[Restaurants.dishes] as? [String : Any] else { return }
                guard let dataBaseCategory = data[Restaurants.categories] as? [String : Any] else { return }
                addDishesIntoTableView(withRequest: dataBaseCategory, dishes: dishes)
            }
        }
    }
    
    private func addDishesIntoTableView(withRequest dataBaseCategory: [String : Any], dishes: [String : Any]) {
        for it in dataBaseCategory {
            guard let newIt = it.value as? [String : Any] else { return }
            if newIt[DishCategory.K.id] as? String == self.category.id {
                for dish in dishes {
                    if category.dishes.contains(dish.key) {
                        guard let newDish = dish.value as? [String : Any] else { return }
                        let finalDish = Dish(id: dish.key,
                                             name: newDish[Dish.K.name] as? String,
                                             image: newDish[Dish.K.image] as? String,
                                             description: newDish[Dish.K.description] as? String,
                                             calories: newDish[Dish.K.calories] as? Int ?? 0)
                        
                        self.dishes.append(finalDish)
                        DispatchQueue.main.async {
                            self.tableView.reloadData(
                                with: .simple(duration: 0.75, direction: .rotation3D(type: .spiderMan),
                                              constantDelay: 0))
                        }
                    }
                }
            }
        }
    }
}
