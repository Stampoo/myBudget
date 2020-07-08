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
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.masksToBounds = false
    }

    func addBloom(color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.9
        layer.shadowOffset = .zero
    }
    
}

extension UIView {

    func setConstraints(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
