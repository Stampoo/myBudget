//
//  ScoreTableViewCell.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class ScoreTableViewCell: UITableViewCell {

    //MARK: - Constants

    private enum Constants {
        static let monthTitle = "Month budget"
        static let spentTtitle = "Spent budget"
    }

    //MARK: - IBOutlets

    @IBOutlet private weak var budgetTitle: UILabel!
    @IBOutlet private weak var budgetAmount: UILabel!
    @IBOutlet private weak var spentTitle: UILabel!
    @IBOutlet private weak var spentAmount: UILabel!
    @IBOutlet private weak var BudgetName: UILabel!
    @IBOutlet private weak var budgetBar: UIProgressView!


    //MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        
    }


    //MARK: - Public methods

    func configureCell(with budget: Budget) {
        budgetTitle.text = Constants.monthTitle
        budgetAmount.text = "\(budget.amount)"
        spentTitle.text = Constants.spentTtitle
        let spent = calculateSpent(budget: budget)
        spentAmount.text = "\(spent)"
        configureProgress(at: budget)
    }


    //MARK: - Private methods

    private func calculateSpent(budget: Budget) -> Double {
        var spent = 0.0
        let history = TempHistoryStorageService.shared.openHistory(budget: budget)
        history.forEach { spent += $0.anount }
        return spent
    }

    private func configureLabels() {

    }

    private func configureProgress(at budget: Budget) {
        let onePercentBudget = budget.amount / 100
        let spent = calculateSpent(budget: budget)
        let progress = 100 - spent / onePercentBudget
        budgetBar.progress = Float(progress)
    }
    
}
