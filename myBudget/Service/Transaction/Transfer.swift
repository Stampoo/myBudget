//
//  Transfer.swift
//  myBudget
//
//  Created by fivecoil on 29/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class Transfer {


    //MARK: - Private properties

    private let transactionStoraget = TempHistoryStorageService.shared
    private let budgetStorage = TempBudgetStorageService.shared


    //MARK: - Public methods

    func trasferMoney(from: Budget, to: Budget, amount: Double) {
        writeInHistory(from: from, to: to, amount: amount)
    }


    //MARK: - Private methods

    private func writeInHistory(from: Budget, to: Budget, amount: Double) {
        guard let convertedMoney = convertMoneyFrom(from: from, to: to, amount: amount) else {
            return
        }
        let transactionFrom = Transaction(name: "Outgoing transfer", amount: -amount, date: Date())
        let transactionTo = Transaction(name: "Incoming transfer", amount: convertedMoney, date: Date())
        transactionStoraget.addTransactionInHistory(budget: from, transaction: transactionFrom)
        transactionStoraget.addTransactionInHistory(budget: to, transaction: transactionTo)
    }

    private func convertMoneyFrom(from: Budget, to: Budget, amount: Double) -> Double? {
        let converter = CurrencyConverter()
        return converter.convert(from: from.currency, to: to.currency, amount: amount)
    }

}
