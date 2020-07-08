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

    func setupInitialState(with transactionHistory: [Transaction])

}

protocol TransactionViewOutput: class {

    func reload()

    func viewLoaded()

    func present()

    func push()

}

protocol TransactionViewRouterInput: class {

    func pushModule(with moduleOutput: ModuleOutput)

    func presentModule(with moduleOutput: TransactionModuleOutput)

    func dismiss()

    func popModule()

}

protocol TransactionModuleOutput: class {

    func moduleOutput(with transaction: Transaction)

    func isTransactionAdd(answer: (Bool) -> Void)

}
