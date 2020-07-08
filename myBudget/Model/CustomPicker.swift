//
//  CustomPicker.swift
//  myBudget
//
//  Created by fivecoil on 06/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class PickerConfigurator {

    //MARK: - Pirvate properties

    private let picker: UIPickerView
    private let view: UIView


    //MARK: - initializers

    init(picker: inout UIPickerView, at view: inout UIView) {
        self.picker = picker
        self.view = view
    }

    

}
