//
//  TransactionFilter.swift
//  myBudget
//
//  Created by fivecoil on 29/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class TransactionSorter {

    //MARK: - Types

    enum SortType {
        case date
    }


    //MARK: - Private properties

    private let transactionStorage = TempHistoryStorageService.shared


    //MARK: - Public methods

    func sortBy(type: SortType, to budget: Budget) -> [Transaction] {
        switch type {
        case .date:
            return sortByDate(to: budget)
        }
    }


    //MARK: - Private methods

    private func sortByDate(to budget: Budget) -> [Transaction] {
        let transactions = transactionStorage.openHistory(budget: budget)
        return transactions.sorted { $0.date > $1.date }
    }

}
