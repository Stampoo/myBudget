//
//  TransactionRouter.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class TransactionRouter {

    //MARK: - Public properties

    weak var view: ModuleTransitionable?

}


//MARK: - Extensions

extension TransactionRouter: TransactionViewRouterInput {

    func pushModule(with moduleOutput: ModuleOutput) {
        let editModule = EditBudgetConfigurator().configureModule(with: moduleOutput)
        view?.pushModule(module: editModule, animated: true)
    }

    func presentModule(with moduleOutput: TransactionModuleOutput) {
        let addModule = AddConfigurator().configureModule(with: moduleOutput)
        view?.presentModule(module: addModule, animated: true, completion: nil)
    }

    func dismiss() {
        view?.dismiss(completion: nil)
    }

    func popModule() {
        view?.popModule(animated: true)
    }

}
