//
//  UIVIew.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

extension UIView {
    
    func addLightShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = .init(width: 0.5, height: 4.0)
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }

    func addBloom(color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.9
        self.layer.shadowOffset = .zero
    }
    
}
