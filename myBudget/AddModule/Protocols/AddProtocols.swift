//
//  AddProtocols.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol AddViewInput: class {

    func configureDate()

    func configureCurrency()

}

protocol AddViewOutput: class {

    func reload()

    func dismiss(with newBudget: Budget)

    func dismiss(with newTransaction: Transaction)

    func pop(with newBudget: Budget)

}

protocol AddViewRouterInput: class {

    func dismiss()

    func popModule()

}
