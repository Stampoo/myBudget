//
//  TransactionPresenter.swift
//  myBudget
//
//  Created by fivecoil on 27/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class TransactionPresenter {

    //MARK: - Public properties

    var view: TransactionViewInput?
    var router: TransactionViewRouterInput?
    var moduleOutput: ModuleOutput?

}


//MARK: - Extensions

extension TransactionPresenter: TransactionViewOutput {

    func reload() {}

    func viewLoaded() {}

    func dismiss(with newBudget: Budget) {}

    func pop(with newBudget: Budget) {}

}
