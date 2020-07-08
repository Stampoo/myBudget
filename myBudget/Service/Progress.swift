//
//  ProgressCalculate.swift
//  myBudget
//
//  Created by fivecoil on 30/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

final class Progress {

    //MARK: - Private properties

    private var currentProgress: Float
    private let progressView: UIView
    private let absoluteWidth = UIScreen.main.bounds.width - 15


    //MARK: - Initizliers

    init(budget: Budget, progressView: UIView) {
        self.currentProgress = 0
        self.progressView = progressView
        self.currentProgress = calculateCurrentProgress(at: budget)
    }


    //MARK: - Public methods

    func calculateProgress() -> CGFloat {
        calculateColor()
        return calculatePercentFilling(at: currentProgress)
    }


    //MARK: - Private methods

    private func calculateColor() {
        var color = UIColor()
        switch currentProgress {
        case 0..<20:
            color = UIColor.shared.getCustom(color: .red)
        case 20..<60:
            color = UIColor.shared.getCustom(color: .orange)
        case 60...100:
            color = UIColor.shared.getCustom(color: .green)
        default:
            color = UIColor.shared.getCustom(color: .blue)
        }
        progressView.backgroundColor = color
    }

    private func calculateCurrentProgress(at budget: Budget) -> Float {
        let historyStorage = TempHistoryStorageService()
        let spent = historyStorage.calculateSpent(budget: budget)
        let progress = 100 - (spent / (budget.amount / 100))
        return Float(progress)
    }

    private func calculatePercentFilling(at progress: Float) -> CGFloat {
        if progress <= 100 {
            let filling = absoluteWidth - (absoluteWidth / 100) * CGFloat(progress)
            return filling
        } else {
            return 0
        }
    }
    
}
