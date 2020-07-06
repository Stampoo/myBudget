//
//  History.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    let name: String
    let amount: Double
    let date: Date
    var transfer = TransferOption()
}

struct TransferOption: Codable {
    var isTransfer = false
    var isOutput = false
}
