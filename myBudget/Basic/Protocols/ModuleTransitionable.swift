//
//  ModuleTransitionable.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

protocol ModuleTransitionable: class {
    
    typealias EmptyColser = () -> Void
    
    func presentModule(module: UIViewController, animated: Bool, completion: EmptyColser?)
    
    func dismiss(completion: EmptyColser?)
    
    func pushModule(module: UIViewController, animated: Bool)
    
    func popModule(animated: Bool)
    
}


extension ModuleTransitionable where Self: UIViewController {
    
    func presentModule(module: UIViewController, animated: Bool, completion: EmptyColser?) {
        self.present(module, animated: animated, completion: completion)
    }
    
    func dismiss(completion: EmptyColser?) {
        self.dismiss(animated: true, completion: completion)
    }
    
    func pushModule(module: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(module, animated: animated)
    }
    
    func popModule(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
    
}
