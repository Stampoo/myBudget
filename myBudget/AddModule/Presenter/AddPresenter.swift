//
//  AddPresenter.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class AddPresenter {

    //MARK: - Public properties

    var view: AddViewInput?
    var router: AddViewRouterInput?
    var moduleOutput: ModuleOutput?
    var transactionModuleOutput: TransactionModuleOutput?

}


//MARK: - Extensions

extension AddPresenter: AddViewOutput {

    func reload() {
        guard let _ = transactionModuleOutput?.isTransactionAdd(answer: { (answer) in
            if answer {
                view?.configureDate()
            }
        }) else {
             view?.configureCurrency()
            return
        }
    }

    func viewLoaded() {}

    func dismiss(with newBudget: Budget) {
        moduleOutput?.moduleOutput(with: newBudget)
        router?.dismiss()
    }

    func pop(with newBudget: Budget) {
        moduleOutput?.moduleOutput(with: newBudget)
        router?.popModule()
    }

    func dismiss(with newTransaction: Transaction) {
        transactionModuleOutput?.moduleOutput(with: newTransaction)
        router?.dismiss()
    }

}
