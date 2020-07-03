//
//  Concurrency.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

enum Currency: String, Codable, CaseIterable {
    case ruble = "RUB"
    case bRuble = "BYN"
    case USD = "USD"
    case euro = "EUR"
}
