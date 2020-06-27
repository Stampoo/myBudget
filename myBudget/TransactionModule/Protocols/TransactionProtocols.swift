//
//  TransactionProtocols.swift
//  myBudget
//
//  Created by fivecoil on 27/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol TransactionViewInput: class {

    func configure(with budget: Budget)

    func setupInitialState()

}

protocol TransactionViewOutput: class {

    func reload()

    func viewLoaded()

}

protocol TransactionViewRouterInput: class {

    func pushModule()

    func presentModule()

    func dismiss()

    func popModule()

}

