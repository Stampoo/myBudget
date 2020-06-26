//
//  ScorePresenter.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class ScorePresenter {
    
    //MARK: - Public properties
    
    var view: ScoreViewInput?
    var router: ScoreViewRouterInput?
    
}


//MARK: - Extensions

extension ScorePresenter: ScoreViewOutput {
    
    func reload() {}
    
    func viewLoaded() {}
    
}
