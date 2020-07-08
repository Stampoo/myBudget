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
        var transactions = transactionStorage.openHistory(budget: budget)
        for (index, _) in transactions.enumerated() {
            let left = transactions.count - index - 1
            for secondIndex in 0..<left {
                swap(left: secondIndex, right: secondIndex + 1, array: &transactions)
            }
        }
        return transactions
    }

    private func swap(left: Int, right: Int, array: inout [Transaction]) {
        var tempSlot: Transaction
        if array[left].date > array[right].date {
            tempSlot = array[left]
            array[left] = array[right]
            array[right] = tempSlot
        }
    }

}
