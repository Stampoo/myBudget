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
    
}

protocol ScoreViewRouterInput: class {
    
    func pushModule()
    
    func presentModule(with moduleOutput: ModuleOutput)
    
    func dismiss()
    
    func popModule()
    
}

protocol ModuleOutput: class {

    func moduleOutput(with budget: Budget)

}
