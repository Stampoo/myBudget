//
//  TransactionViewController.swift
//  myBudget
//
//  Created by fivecoil on 28/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class TransactionViewController: UIViewController, ModuleTransitionable {

    //MARK: - IBOutlets

    @IBOutlet private weak var nameBudgetLabel: UILabel!
    @IBOutlet private weak var backgroundTopView: UIView!
    @IBOutlet private weak var transferButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var budgetAmountLabel: UILabel!
    @IBOutlet private weak var budgetSpentLabel: UILabel!


    //MARK: - Public properties

    var output: TransactionViewOutput?


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewLoaded()
        configureLables()
    }


    //MARK: - Privat methods

    private func configureLables() {
        nameBudgetLabel.textColor = .white
    }

}


//MARK: - Extensions

extension TransactionViewController: TransactionViewInput {
    
    func configure(with budget: Budget) {
        nameBudgetLabel.text = budget.name
        budgetAmountLabel.text = "Budget = \(budget.amount)"
        budgetSpentLabel.text = "Budget"
    }

    func setupInitialState() {}

}
