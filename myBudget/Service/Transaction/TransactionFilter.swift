//
//  TransactionFilter.swift
//  myBudget
//
//  Created by fivecoil on 29/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class TransactionFilter {

    //MARK: - Types

    enum FilterType {
        case date
    }


    //MARK: - Private properties

    private let transactionStorage = TempHistoryStorageService.shared

    //MARK: - Public methods

    func filterBy(type: FilterType, to budget: Budget) -> [Transaction] {
        switch type {
        case .date:
            return filterByDate(to: budget)
        }
    }


    //MARK: - Private methods

    private func filterByDate(to budget: Budget) -> [Transaction] {
        var tempSlotForTransaction: Transaction
        var transactions = transactionStorage.openHistory(budget: budget)
        for (index, transaction) in transactions.enumerated() {
            for (ind, trans) in transactions.enumerated() {
                if transaction.date < trans.date {
                    tempSlotForTransaction = transaction
                    transactions[index] = trans
                    transactions[ind] = tempSlotForTransaction
                }
            }
        }
        return transactions
    }

}
