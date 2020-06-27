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
    
    var view: ScoreViewInput?
    var router: ScoreViewRouterInput?


    //MARK: - Private properties

    private let budgetStorage = TempBudgetStorageService.shared
    private let historyStorage = TempHistoryStorageService.shared


    //MARK: - Private methods
    
}


//MARK: - Extensions

extension ScorePresenter: ScoreViewOutput {
    
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
    
}

extension ScorePresenter: ModuleOutput {

    func moduleOutput(with budget: Budget) {
        budgetStorage.addBudgetInList(budget: budget)
        let budgetList = budgetStorage.openBudgetList()
        view?.configure(with: budgetList)
    }

}
