//
//  AddConfigurator.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class AddConfigurator {

    func configureModule(with moduleOutput: ModuleOutput) -> UIViewController {

        let view = AddViewController()
        let presenter = AddPresenter()
        let router = AddRouter()

        view.output = presenter
        presenter.view = view
        presenter.router = router
        presenter.moduleOutput = moduleOutput
        router.view = view

        return view
    }

    func configureModule(with moduleOutput: TransactionModuleOutput) -> UIViewController {

           let view = AddViewController()
           let presenter = AddPresenter()
           let router = AddRouter()

           view.output = presenter
           presenter.view = view
           presenter.router = router
           presenter.transactionModuleOutput = moduleOutput
           router.view = view

           return view
       }

}
