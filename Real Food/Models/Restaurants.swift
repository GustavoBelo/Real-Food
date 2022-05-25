//
//  Restaurants.swift
//  Real Food
//
//  Created by Gustavo Belo on 22/12/21.
//

import Foundation

struct Restaurants {
    static let identifierGroup = String(describing: Self.self)
    static let identifier = "restaurant"
    
    struct Document {
        struct Branches {
            struct Document {
                static let classifications = "classifications"
                struct Dishes {
                    static let identifier = "dishes"
                    static let aditionalDishes = "aditional dishes"
                }
                struct Days {
                    static let identifier = "days"
                    static let days = ["segunda-feira", "terça-feira", "quarta-feira", "quinta-feira", "sábado", "domingo"]
                    static let openingHours = "opening hours"
                    static let closeStatus = "close"
                    static let openStatus = "open"
                }
            }
        }
        
        static let price = "averege price"
        static let name = "name"
        static let payments = "payments"
    }
    
    static let categories = "categories"
    static let dishes = "dishes"
    static let image = "image"
    static let name = "name"
    static let populars = "populars"
    static let specials = "specials"
}
