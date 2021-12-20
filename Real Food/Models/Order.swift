//
//  Order.swift
//  Real Food
//
//  Created by Gustavo Belo on 15/12/21.
//

import Foundation

struct Order {
    struct K {
        static let identifierGroup = identifier + "s"
        static let identifier = "Order"
        static let restaurant = "restaurant"
        static let name = "name"
        static let date = "date"
        static let table = "table"
        static let sender = "sender"
    }
    let name, sender: String?
    let dish: Dish?
}
