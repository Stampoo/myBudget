//
//  EditBudgetRouter.swift
//  myBudget
//
//  Created by fivecoil on 06/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class EditBudgetRouter {

    //MARK: - Public properties

    var view: ModuleTransitionable?

}


//MARK: - Extensions

extension EditBudgetRouter: EditBudgetViewRouterInput {

    func pushModule() {}

    func presentModule() {}

    func dismiss() {
        view?.dismiss(completion: nil)
    }

    func popModule() {
        view?.popModule(animated: true)
    }

}
