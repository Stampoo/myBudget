//
//  CurrencyRate.swift
//  myBudget
//
//  Created by fivecoil on 01/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct CurrencyRate: Codable {
    let success: Bool
    let base: String
    let rates: Rates
}

struct Rates: Codable {
    let BYN: String?
    let RUB: String?
    let USD: String?
    let EUR: String?
}
