//
//  EditBudgetConfigurator.swift
//  myBudget
//
//  Created by fivecoil on 06/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class EditBudgetConfigurator {

    func configureModule(with moduleOutput: ModuleOutput) -> UIViewController {

        let view = EditBudgetViewController()
        let presenter = EditBudgetPresenter()
        let router = EditBudgetRouter()

        view.output = presenter
        presenter.view = view
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        router.view = view

        return view
    }

}
