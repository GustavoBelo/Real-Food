//
//  String+Extentsion.swift
//  Real Food
//
//  Created by Gustavo Belo on 10/12/21.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
