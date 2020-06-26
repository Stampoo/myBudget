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
    
    func pushModule() {}
    
    func presentModule() {}
    
    func dismiss() {
        view?.dismiss(completion: nil)
    }
    
    func popModule() {
        view?.popModule(animated: true)
    }
    
}
