//
//  AddTransactionProtocols.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol AddTransactionViewInput: class {

    func configure(with budget: Budget)

    func setupInitialState()

}

protocol AddTransactionViewOutput: class {

    func reload()

    func viewLoaded()

}

protocol AddTransactionViewRouterInput: class {

    func pushModule()

    func presentModule()

    func dismiss()

    func popModule()

}
