//
//  EditBudgetProtocols.swift
//  myBudget
//
//  Created by fivecoil on 06/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol EditBudgetViewInput: class {

    func configure(with budget: Budget)

    func setupInitialState()

}

protocol EditBudgetViewOutput: class {

    func reload(with newBudget: Budget)

    func viewLoaded()

}

protocol EditBudgetViewRouterInput: class {

    func pushModule()

    func presentModule()

    func dismiss()

    func popModule()

}
