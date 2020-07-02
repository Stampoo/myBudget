//
//  Concurrency.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

enum Currency: String, Codable, CaseIterable {
    case ruble = "₽"
    case bRuble = "Br"
    case USD = "$"
    case euro = "€"
}

protocol CurrencyType {
    var rawValue: String { get }
}

extension Currency: CurrencyType {

    var rawValue: String {
        switch self {
        case .bRuble:
            return "BYN"
        case .euro:
            return "EUR"
        case .ruble:
            return "RUB"
        case .USD:
            return "USD"
        }
    }

}

