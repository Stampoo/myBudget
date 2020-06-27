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
    let budgetStorage = TempBudgetStorageService.shared
    
}


//MARK: - Extensions

extension ScorePresenter: ScoreViewOutput {
    
    func reload() {}
    
    func viewLoaded() {}

    func presentModule() {
        router?.presentModule(with: self)
    }
    
}

extension ScorePresenter: ModuleOutput {

    func moduleOutput(with budget: Budget) {
        budgetStorage.addBudgetInList(budget: budget)
    }

}
