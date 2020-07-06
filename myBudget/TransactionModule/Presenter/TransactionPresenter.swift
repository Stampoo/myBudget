//
//  TransactionPresenter.swift
//  myBudget
//
//  Created by fivecoil on 27/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class TransactionPresenter {

    //MARK: - Public properties

    var view: TransactionViewInput?
    var router: TransactionViewRouterInput?
    var moduleOutput: ModuleOutput?


    //MARK: - Private properties

    private let transactionStorage = TempHistoryStorageService.shared
    private var budget: Budget?

}


//MARK: - Extensions

extension TransactionPresenter: TransactionViewOutput {

    func reload() {
        guard let budget = budget else {
            return
        }
        let transactionHistory = transactionStorage.openHistory(budget: budget)
        view?.setupInitialState(with: transactionHistory)
        view?.configure(with: budget)
    }

    func viewLoaded() {
        moduleOutput?.transitionBudget(completion: { (budget) in
            self.budget = budget
            self.view?.configure(with: budget)
            self.view?.setupInitialState(with: transactionStorage.openHistory(budget: budget))
        })
    }

    func push() {
        router?.pushModule(with: self)
    }

    func present() {
        router?.presentModule(with: self)
    }

}

extension TransactionPresenter: TransactionModuleOutput {

    func isTransactionAdd(answer: (Bool) -> Void) {
        answer(true)
    }

    func moduleOutput(with transaction: Transaction) {
        guard let budget = budget else {
            return
        }
        transactionStorage.addTransactionInHistory(budget: budget, transaction: transaction)
        view?.configure(with: budget)
    }
    
}

extension TransactionPresenter: ModuleOutput {

    func moduleOutput(with budget: Budget) {
        self.budget = budget
        view?.configure(with: budget)
    }

    func transitionBudget(completion: (Budget) -> Void) {
        guard let budget = budget else {
            return
        }
        completion(budget)
    }

}
