//
//  UIColor.swift
//  myBudget
//
//  Created by fivecoil on 27/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

extension UIColor {

    static let shared = UIColor()

    enum CustomColors: CustomColorsRawValue {
        var rawValue: [CGFloat] {
            switch self {
            case .lightGray:
                return [233, 239, 237]
            case .blue:
                return [60, 122, 254]
            case .gray:
                return [238, 238, 240]
            case .indigo:
                return [88, 86, 214]
            }
        }

        case blue
        case gray
        case lightGray
        case indigo
    }

    func getCustom(color: CustomColors) -> UIColor {
        return getColor(color: color)
    }

    private func getColor(color: CustomColorsRawValue) -> UIColor {
        return .init(red: color.rawValue[0] / 255,
                     green: color.rawValue[1] / 255,
                     blue: color.rawValue[2] / 255, alpha: 1)
    }

}

protocol CustomColorsRawValue {
    var rawValue: [CGFloat] { get }
}
