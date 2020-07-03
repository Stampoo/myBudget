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
        static let monthTitle = "Budget"
        static let spentTtitle = "Spent from this budget"
    }

    //MARK: - IBOutlets

    @IBOutlet private weak var budgetAmount: UILabel!
    @IBOutlet private weak var budgetTitle: UILabel!
    @IBOutlet private weak var spentTitle: UILabel!
    @IBOutlet private weak var spentAmount: UILabel!
    @IBOutlet private weak var BudgetName: UILabel!
    @IBOutlet private weak var budgetBar: UIProgressView!
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var shadowView: UIView!


    //MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCard()
        configureLabels()
        configureBar()
        self.contentView.backgroundColor = UIColor().getCustom(color: .lightGray)
    }


    //MARK: - Public methods

    func configureCell(with budget: Budget) {
        let symbol = budget.currency.rawValue.getCurrencyLiteral()
        BudgetName.text = budget.name
        budgetAmount.text = "\(budget.amount) \(symbol)"
        let spent = calculateSpent(budget: budget)
        spentAmount.text = "\(spent) \(symbol)"
        configureProgress(at: budget)
    }


    //MARK: - Private methods

    private func calculateSpent(budget: Budget) -> Double {
        var spent = 0.0
        let history = TempHistoryStorageService.shared.openHistory(budget: budget)
        history.forEach { spent += $0.amount }
        return spent
    }

    private func configureLabels() {
        budgetTitle.text = Constants.monthTitle
        spentTitle.text = Constants.spentTtitle
    }

    private func configureBar() {
    }

    private func configureCard() {
        selectionStyle = .none
        cardView.layer.cornerRadius = cardView.frame.height / 8
        cardView.clipsToBounds = true
        shadowView.clipsToBounds = false
        shadowView.addLightShadow()
    }

    private func configureProgress(at budget: Budget) {
        let onePercentBudget = budget.amount / 100
        let spent = calculateSpent(budget: budget)
        let progress = 100 - spent / onePercentBudget
        budgetBar.progress = Float(progress)
    }
    
}
