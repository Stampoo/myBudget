//
//  TransactionProtocols.swift
//  myBudget
//
//  Created by fivecoil on 27/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol TransactionViewInput: class {

    func configure(with transaction: Transaction)

    func configure(with budget: Budget)

    func setupInitialState(with transactionHistory: [Transaction])

}

protocol TransactionViewOutput: class {

    func reload()

    func viewLoaded()

    func present()

}

protocol TransactionViewRouterInput: class {

    func pushModule()

    func presentModule(with moduleOutput: TransactionModuleOutput)

    func dismiss()

    func popModule()

}

protocol TransactionModuleOutput: class {

    func moduleOutput(with transaction: Transaction)

    func isTransactionAdd(answer: (Bool) -> Void)

}
