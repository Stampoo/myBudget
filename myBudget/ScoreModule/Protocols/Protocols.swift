//
//  Protocols.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol ScoreViewInput: class {
    
    func configure()
    
    func setupInitialState()
    
}

protocol ScoreViewOutput: class {
    
    func reload()
    
    func viewLoaded()
    
}

protocol ScoreViewRouterInput: class {
    
    func pushModule()
    
    func presentModule()
    
    func dismiss()
    
    func popModule()
    
}
