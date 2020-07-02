//
//  Double.swift
//  myBudget
//
//  Created by fivecoil on 01/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

extension Double {

    enum Currency: String {
        case USD = "USD"
        case bRuble = "BYN"
        case ruble = "RUB"
        case euro = "EUR"
    }

    func convert(to: Currency) {
        let converter = CurrencyConverter()
    }

}
