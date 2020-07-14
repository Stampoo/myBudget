//
//  Budget.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct Budget: Codable {
    let name: String
    var amount: Double
    let currency: Currency
    var transaction = [Transaction]()
}

extension Budget: Equatable {

    static func == (lhs: Budget, rhs: Budget) -> Bool {
        if lhs.name == rhs.name,
            lhs.amount == rhs.amount,
            lhs.currency == rhs.currency {
            return true
        } else {
            return false
        }
    }
    
}
