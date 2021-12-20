//
//  ListDishesViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 14/12/21.
//

import UIKit

class ListDishesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var category: DishCategory!
    var restaurant: String!
    
    //get from each category
    
    var dishes: [Dish] = [
        .init(id: "id1", name: "Fried Plan", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: 34),
        .init(id: "id1", name: "Beans and Garri", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted, This is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tasted" , calories: 34),
        .init(id: "id1", name: "Feijoada", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCells()
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
