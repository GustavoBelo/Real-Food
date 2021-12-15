//
//  ListOrdersViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 15/12/21.
//

import UIKit

class ListOrdersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var orders: [Order] = [
        .init(id: "id", name: "Gustavo", dish: .init(id: "id1", name: "Fried Plan", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: 34)),
        .init(id: "id", name: "2", dish: .init(id: "id1", name: "Beans", image:"https://picsum.photos/100/200", description: "This is the best i have ever tasted" , calories: nil)),
        .init(id: "id", name: "32", dish: .init(id: "id1", name: "Feijoada", image:"https://picsum.photos/100/200", description: "This is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tastedThis is the best i have ever tasted" , calories: 34))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
}
extension ListOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setup(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
}
