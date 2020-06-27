//
//  Protocols.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol ScoreViewInput: class {
    
    func configure(with budgetList: [Budget])
    
    func setupInitialState()
    
}

protocol ScoreViewOutput: class {
    
    func reload()
    
    func viewLoaded()

    func presentModule()

    func pushModule()

    func pushTransactionModule(with budget: Budget)
    
}

protocol ScoreViewRouterInput: class {

    func pushModule(with moduleOutput: ModuleOutput)

    func pushTransactionModule(with moduleOutput: ModuleOutput)
    
    func presentModule(with moduleOutput: ModuleOutput)
    
    func dismiss()
    
    func popModule()
    
}

protocol ModuleOutput: class {

    func moduleOutput(with budget: Budget)

    func transitionBudget(completion: (Budget) -> Void)

}

protocol ModuleInput: class {

    func configure(with budget: Budget)
    
}

