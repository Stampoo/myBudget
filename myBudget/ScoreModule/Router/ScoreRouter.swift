//
//  ScoreRouter.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class ScoreRouter {
    
    //MARK: - Public properties
    
    var view: ModuleTransitionable?
    
}


//MARK: - Extensions

extension ScoreRouter: ScoreViewRouterInput {

    func pushTransactionModule(with moduleOutput: ModuleOutput) {
        let transactionModule = TransactionConfigurator().configureModule(with: moduleOutput)
        view?.pushModule(module: transactionModule, animated: true)
    }
    
    func pushModule(with moduleOutput: ModuleOutput) {
        let addModule = AddConfigurator().configureModule(with: moduleOutput)
        view?.pushModule(module: addModule, animated: true)
    }
    
    func presentModule(with moduleOutput: ModuleOutput) {}
    
    func dismiss() {
        view?.dismiss(completion: nil)
    }
    
    func popModule() {
        view?.popModule(animated: true)
    }
    
}
