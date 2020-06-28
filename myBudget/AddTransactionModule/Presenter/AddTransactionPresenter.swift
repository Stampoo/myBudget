//
//  AddTransactionPresenter.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class AddTransactionPresenter {

    //MARK: - Public properties

    var view: AddTransactionViewInput?
    var router: AddTransactionViewRouterInput?
    var moduleOutput: ModuleOutput?

}


//MARK: - Extensions

extension AddTransactionPresenter: AddTransactionViewOutput {

    func reload() {}

    func viewLoaded() {
        moduleOutput?.transitionBudget(completion: { (budget) in
            self.view?.configure(with: budget)
        })
    }

    func dismiss(with newBudget: Budget) {}

    func pop(with newBudget: Budget) {}

}
