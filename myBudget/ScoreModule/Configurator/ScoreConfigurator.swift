//
//  Configurator.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class ScoreConfigurator {

    //MARK: - Public methods
    
    func configureModule() -> UIViewController {
        
        let view = ScoreViewController()
        let presenter = ScorePresenter()
        let router = ScoreRouter()
        
        view.output = presenter
        presenter.view = view
        presenter.router = router
        router.view = view
        
        return view
    }
    
}
