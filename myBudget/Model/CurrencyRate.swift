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
    let error: Errors?
    let base: String?
    let rates: Rates?
}

struct Rates: Codable {
    let BYN: Double?
    let RUB: Double?
    let USD: Double?
    let EUR: Double?
}

struct Errors: Codable {
    let code: Int
    let type: String
}
