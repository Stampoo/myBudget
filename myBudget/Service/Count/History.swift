//
//  History.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

struct Transaction {
    let anount: Double
    let concurrency: Concurrency
    let category: Category
    let date = Date()
}
