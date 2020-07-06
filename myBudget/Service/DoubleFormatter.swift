//
//  DoubleFormatter.swift
//  myBudget
//
//  Created by fivecoil on 03/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class DoubleFormatter {

    //MARK: - Constants

    private enum Constants {
        static let pointSeparator: Character = "."
    }


    //MARK: - Public properties

    static let shared = DoubleFormatter()


    //MARK: - Public methods

    func convertToString(from double: Double) -> String {
        let numberList = String(double).split(separator: Constants.pointSeparator)
        let afterPoint = numberList[1]
        let beforePoint = numberList[0]
        let formattedBeforePoint = beforePoint + "." + rounded(string: String(afterPoint), to: 2)
        if double.isInt {
            return String(beforePoint)
        } else {
            return String(formattedBeforePoint)
        }
    }


    //MARK: - Private methods

    private func rounded(string: String, to count: Int) -> String {
        var roundedString = ""
        for (index, char) in string.enumerated() {
            if index < count {
                roundedString += String(char)
            }
        }
        return roundedString
    }

}
