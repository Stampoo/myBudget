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
        static let monthTitle = "Budget:"
        static let spentTtitle = "Spent:"
    }

    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var spentTitle: UILabel!
    @IBOutlet private weak var budgetTitle: UILabel!
    @IBOutlet private weak var budgetAmount: UILabel!
    @IBOutlet private weak var spentAmount: UILabel!
    @IBOutlet private weak var budgetName: UILabel!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var progressView: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var progressViewConstraint: NSLayoutConstraint!
    
    
    //MARK: - Private properties
    
    private let colorPickView = PickColorView()
    private let transactionStorage = TempHistoryStorageService.shared
    
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCard()
        configureLabels()
        protectFromNightMode()
    }
    
    
    //MARK: - Public methods
    
    func configureCell(with budget: Budget) {
        let progress = Progress(budget: budget, progressView: progressView)
        let symbol = budget.currency.rawValue.getCurrencyLiteral()
        let spent = transactionStorage.calculateSpent(budget: budget)
        progressViewConstraint.constant = progress.calculateProgress()
        budgetName.text = budget.name
        budgetAmount.text = DoubleFormatter.shared.convertToString(from: budget.amount) + symbol
        spentAmount.text = DoubleFormatter.shared.convertToString(from: spent) + symbol
    }
    
    
    //MARK: - Private methods
    
    private func configureLabels() {
        budgetTitle.text = Constants.monthTitle
        spentTitle.text = Constants.spentTtitle
    }
    
    private func configureCard() {
        selectionStyle = .none
        cardView.layer.cornerRadius = cardView.frame.height / 8
        cardView.layer.masksToBounds = true
        shadowView.addLightShadow()
    }

    private func protectFromNightMode() {
        [
            spentTitle,
            budgetTitle,
            budgetAmount,
            spentAmount,
            budgetName
            ].forEach { $0?.textColor = .black }
    }
    
}
