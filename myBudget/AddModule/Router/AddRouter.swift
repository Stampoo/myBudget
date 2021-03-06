//
//  AddRouter.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class AddRouter {

    //MARK: - Public properties

    weak var view: ModuleTransitionable?

}


//MARK: - Extensions

extension AddRouter: AddViewRouterInput {

    func dismiss() {
        view?.dismiss(completion: nil)
    }

    func popModule() {
        view?.popModule(animated: true)
    }

}
