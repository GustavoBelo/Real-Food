//
//  ListOrdersViewController.swift
//  Real Food
//
//  Created by Gustavo Belo on 15/12/21.
//

import UIKit
import Firebase
import TableViewReloadAnimation

class ListOrdersViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let db = Firestore.firestore()
    private var orders: [Order] = []
    
    var restaurant: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Order.K.identifierGroup
        registerCells()
        loadOrders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func loadOrders() {
        db.collection(Order.K.identifierGroup)
            .order(by: Order.K.date, descending: true)
            .addSnapshotListener { (querySnapshot, error) in
                self.orders = []
                if let e = error {
                    print(e)
                } else if let snapshotDocuments = querySnapshot?.documents {
                    self.addNewOrder(with: snapshotDocuments)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData(
                            with: .simple(duration: 0.75, direction: .rotation3D(type: .spiderMan),
                                          constantDelay: 0))
                    }
                }
            }
    }
    
    private func addNewOrder(with snapshotDocuments: [QueryDocumentSnapshot]) {
        for doc in snapshotDocuments {
            let data = doc.data()
            let restaurant = data[Order.K.restaurant]
            if self.restaurant == restaurant as? String {
                guard let order = data[Order.K.identifier] as? [String: Any] else { return }
                if let sender = order[Order.K.sender] as? String,
                   sender == Auth.auth().currentUser?.email {
                    let table = order[Order.K.table] as? String
                    guard let dish = order[Dish.K.dish] as? [String : Any] else { return }
                    let dishOrder = Dish(id: dish[Dish.K.id] as? String,
                                         name: dish[Dish.K.name] as? String,
                                         image: dish[Dish.K.image] as? String,
                                         description: dish[Dish.K.description] as? String,
                                         calories: dish[Dish.K.calories] as? Int ?? 0)
                    
                    let newOrder = Order(name: table,
                                         sender: sender,
                                         dish: dishOrder)
                    
                    self.orders.append(newOrder)
                }
            }
        }
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
        controller.restaurant = restaurant
        controller.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(controller, animated: true)
    }
}
