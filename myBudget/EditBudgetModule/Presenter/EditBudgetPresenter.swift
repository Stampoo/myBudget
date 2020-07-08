//
//  EditBudgetPresenter.swift
//  myBudget
//
//  Created by fivecoil on 06/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class EditBudgetPresenter {

    //MARK: - Public properties

    var view: EditBudgetViewInput?
    var router: EditBudgetViewRouterInput?
    var moduleOutput: ModuleOutput?


    //MARK: - Private properties

    private let transactionStorage = TempHistoryStorageService.shared
    private var budget: Budget?

}


//MARK: - Extensions

extension EditBudgetPresenter: EditBudgetViewOutput {

    func reload(with newBudget: Budget) {
        router?.popModule()
        moduleOutput?.moduleOutput(with: newBudget)
    }

    func viewLoaded() {
        moduleOutput?.transitionBudget(completion: { (budget) in
            view?.configure(with: budget)
        })
    }

}
