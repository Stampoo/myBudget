//
//  CustomTextField.swift
//  myBudget
//
//  Created by fivecoil on 03/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class CustomTextField: UITextField {

    //MARK: - Constants

    private enum Constants {
        static let defaultLeft: CGFloat = 10
        static let defaultRight: CGFloat = 10
    }
    

    //MARK: Private properties

    private var inset = UIEdgeInsets(top: 0,
                                     left: Constants.defaultLeft,
                                     bottom: 0,
                                     right: Constants.defaultRight)


    //MARK: - Initializers

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    //MARK: - Lifecycle

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: inset)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: inset)
    }

    //MARK: - Public methods

    func setInset(left: CGFloat, right: CGFloat) {
        inset = .init(top: 0, left: left, bottom: 0, right: right)
        update()
    }


    //MARK: - Private methods

    private func update() {
        draw(bounds)
    }

}
