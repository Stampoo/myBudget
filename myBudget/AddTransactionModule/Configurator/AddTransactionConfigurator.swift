//
//  AddTransactionConfigurator.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class AddTransactionConfigurator {

    func configureModule(with moduleOutput: ModuleOutput) -> UIViewController {

        let view = AddTransactionViewController()
        let presenter = AddTransactionPresenter()
        let router = AddTransactionRouter()

        view.output = presenter
        presenter.view = view
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        router.view = view

        return view
    }

}
