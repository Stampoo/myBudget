//
//  AddTransactionViewController.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class AddTransactionViewController: UIViewController, ModuleTransitionable {

    //MARK: - Public properties

    var output: AddTransactionViewOutput?


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


//MARK: - Extensions

extension AddTransactionViewController: AddTransactionViewInput {

    func configure(with budget: Budget) {}

    func setupInitialState() {}

}
