//
//  Strings.swift
//  Real Food
//
//  Created by Gustavo Belo on 03/07/22.
//

import Foundation

struct Strings {
    struct UserDefaultKeys {
        static let presentedOnboarding = "onboarding_presented"
    }
    
    struct Home {
        static let title = "Real Food"
        struct HeaderView {
            static let title: String = "O que temos para hoje?"
            static let qrCodeIcon = "qrcode"
            static let qrCodeText = "QRCode"
            static let searchRestaurantsIcon = "magnifyingglass"
            static let searchRestaurantsText = "Buscar restautante"
        }
        struct restaurantsExampleView {
            static let title = "Restaurantes"
            static let seeMoreText = "ver todos"
        }
    }
}
