//
//  String.swift
//  myBudget
//
//  Created by fivecoil on 03/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

extension String {

    func getCurrencyLiteral() -> String {
        switch self {
        case "USD":
            return "$"
        case "EUR":
            return "€"
        case "BYN":
            return "Br"
        case "RUB":
            return "₽"
        default:
            return "Not a currency"
        }
    }
}
