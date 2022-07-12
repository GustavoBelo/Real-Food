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
        static let identifierGroup = String(describing: Self.self)
        struct Branches {
            static let identifier = "branch"
            static let identifierGroup = String(describing: Self.self)
            struct Document {
                static let classifications = "classifications"
                struct Dishes {
                    static let identifier = "dishes"
                    static let aditionalDishes = "aditional dishes"
                }
                struct Days {
                    static let identifier = "days"
                    static let days = ["segunda-feira", "terça-feira", "quarta-feira", "quinta-feira", "sábado", "domingo"]
                    static let openingHours = "openingHours"
                    static let closeStatus = "close"
                    static let openStatus = "open"
                }
            }
        }
        
        struct CommonDishes {
            static let arModel = "ARModel"
            static let description = "description"
            static let name = "name"
            static let price = "price"
        }
        
        static let price = "averagePrice"
        static let name = "name"
        static let payments = "payments"
    }
    
    static let category = "category"
    static let categories = "categories"
    static let dishes = "dishes"
    static let image = "image"
    static let name = "name"
    static let populars = "populars"
    static let specials = "specials"
}
