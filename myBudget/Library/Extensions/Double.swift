//
//  Double.swift
//  myBudget
//
//  Created by fivecoil on 01/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

extension Double {

    var isInt: Bool {
        self == self.rounded()
    }

    mutating func formatNumber() -> String {
        if isInt {
            return "\(Int(self))"
        } else {
            let double = (self * 2) / 2
            return "\(Darwin.round(double))"
        }
    }
    
}
