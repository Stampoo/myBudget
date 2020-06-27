//
//  AddPresenter.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class AddPresenter {

    //MARK: - Public properties

    var view: AddViewInput?
    var router: AddViewRouterInput?
    var moduleOutput: ModuleOutput?

}


//MARK: - Extensions

extension AddPresenter: AddViewOutput {

    func reload() {}

    func viewLoaded() {}

    func dismiss(with newBudget: Budget) {
        moduleOutput?.moduleOutput(with: newBudget)
        router?.dismiss()
    }

}
