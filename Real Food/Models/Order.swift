//
//  Order.swift
//  Real Food
//
//  Created by Gustavo Belo on 15/12/21.
//

import Foundation

struct Order {
    static let identifierGroup = String(describing: Self.self)+"s"
    let id, name: String?
    let dish: Dish?
}
