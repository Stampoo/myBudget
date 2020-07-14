//
//  ScorePresenter.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class ScorePresenter {
    
    //MARK: - Public properties
    
    weak var view: ScoreViewInput?
    var router: ScoreViewRouterInput?
    var moduleInput: ModuleInput?


    //MARK: - Private properties

    private let budgetStorage = TempBudgetStorageService.shared
    private let historyStorage = TempHistoryStorageService.shared
    private var budget: Budget?
    private let storageService = StorageService()
    
}


//MARK: - Extensions

extension ScorePresenter: ScoreViewOutput {

    func pushTransactionModule(with budget: Budget) {
        self.budget = budget
        router?.pushTransactionModule(with: self)
    }

    func reload() {
        let budgetList = budgetStorage.openBudgetList()
        view?.configure(with: budgetList)
    }
    
    func viewLoaded() {
        view?.setupInitialState()
    }

    func presentModule() {
        router?.presentModule(with: self)
    }

    func pushModule() {
        router?.pushModule(with: self)
    }
    
}

extension ScorePresenter: ModuleOutput {

    func moduleOutput(with budget: Budget) {
        budgetStorage.addBudgetInList(budget: budget)
        let budgetList = budgetStorage.openBudgetList()
        view?.configure(with: budgetList)
    }

    func transitionBudget(completion: (Budget) -> Void) {
        guard let budget = budget else {
            return
        }
        completion(budget)
    }

}
