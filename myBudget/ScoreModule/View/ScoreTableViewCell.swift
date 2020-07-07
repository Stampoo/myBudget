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
    @IBOutlet private weak var budgetBar: UIProgressView!
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var shadowView: UIView!


    //MARK: - Private properties

    private let colorPickView = PickColorView()
    private let transactionStorage = TempHistoryStorageService.shared


    //MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        configureColorView()
        configureCard()
        configureLabels()
        configureBar()
        configureLeftSide()
        protectFromNightMode()
    }


    //MARK: - Public methods

    func configureCell(with budget: Budget) {
        let symbol = budget.currency.rawValue.getCurrencyLiteral()
        budgetName.text = budget.name
        budgetAmount.text = DoubleFormatter.shared.convertToString(from: budget.amount) + symbol
        let spent = transactionStorage.calculateSpent(budget: budget)
        spentAmount.text = DoubleFormatter.shared.convertToString(from: spent) + symbol
    }


    //MARK: - Private methods

    private func configureColorView() {
        colorView.isUserInteractionEnabled = true
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(appearColorPick))
        colorView.addGestureRecognizer(longTap)
        colorPickView.delegate = self
        addSubview(colorPickView)
        colorPickView.isHidden = true
    }

    @objc private func appearColorPick(longPress: UILongPressGestureRecognizer) {
        let location = longPress.location(in: colorView)
        colorPickView.center = location
        colorPickView.isHidden = false
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
        cardView.layer.masksToBounds = true
        shadowView.addLightShadow()
    }

    private func configureLeftSide() {
        categoryImageView.alpha = 0.3
        categoryImageView.layer.cornerRadius = categoryImageView.frame.height / 2
    }

    private func protectFromNightMode() {
        colorView.backgroundColor = .lightGray
        [
            spentTitle,
            budgetTitle,
            budgetAmount,
            spentAmount,
            budgetName
            ].forEach { $0?.textColor = .black }
    }
    
}


//MARK: - Extensions

extension ScoreTableViewCell: PickColorViewDelegate {

    func didColorSelect(selected colors: UIColor) {
        colorView.backgroundColor = colors
    }

}
