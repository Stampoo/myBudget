//
//  Budget.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct Budget: Codable, Equatable {
    let name: String
    var amount: Double
    let currency: Currency
}
