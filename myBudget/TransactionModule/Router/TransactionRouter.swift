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

    var view: ModuleTransitionable?

}


//MARK: - Extensions

extension TransactionRouter: TransactionViewRouterInput {

    func pushModule() {}

    func presentModule() {}

    func dismiss() {
        view?.dismiss(completion: nil)
    }

    func popModule() {
        view?.popModule(animated: true)
    }

}
