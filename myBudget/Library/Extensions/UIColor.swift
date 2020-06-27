//
//  UIColor.swift
//  myBudget
//
//  Created by fivecoil on 27/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

extension UIColor {
    enum CustomColors {
        case blue
        case gray
    }

    func getCustom(color: CustomColors) -> UIColor {
        switch color {
        case .blue:
            return .init(red: 60/255, green: 122/255, blue: 254/255, alpha: 1)
        case .gray:
            return .init(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
        }
    }
}

