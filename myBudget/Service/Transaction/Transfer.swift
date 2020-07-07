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

    func convert(fromBudget: Budget, toBudget: Budget, amount: Double) -> Double {
        let tryConvert = convertMoneyFrom(from: fromBudget, to: toBudget, amount: amount)
        let converter = CurrencyConverter()
        let transactionStorage = TempHistoryStorageService.shared
        let transactionHistory = transactionStorage.openHistory(budget: toBudget)
        var convertedTransactionHistory = [Transaction]()
        for transaction in transactionHistory {
            let newAmount = converter.convert(from: fromBudget.currency, to: toBudget.currency, amount: transaction.amount)
            let newTransaction = Transaction(name: transaction.name,
                                             amount: newAmount ?? 0,
                                             date: transaction.date,
                                             transfer: transaction.transfer)
            convertedTransactionHistory.append(newTransaction)
        }
        transactionStorage.replaceCurrentTransaction(at: convertedTransactionHistory, for: toBudget)
        guard let convertedAmount = tryConvert else {
            return 0.0
        }
        return convertedAmount
    }


    //MARK: - Private methods

    private func writeInHistory(from: Budget, to: Budget, amount: Double) {
        guard let convertedMoney = convertMoneyFrom(from: from, to: to, amount: amount) else {
            return
        }
        let fromTrasferOption = TransferOption(isTransfer: true, isOutput: true)
        let toTransferOption = TransferOption(isTransfer: true, isOutput: false)
        let transactionFrom = Transaction(name: "Outgoing transfer",
                                          amount: -amount,
                                          date: Date(), transfer: fromTrasferOption)
        let transactionTo = Transaction(name: "Incoming transfer",
                                        amount: convertedMoney,
                                        date: Date(), transfer: toTransferOption)
        transactionStoraget.addTransactionInHistory(budget: from, transaction: transactionFrom)
        transactionStoraget.addTransactionInHistory(budget: to, transaction: transactionTo)
    }

    private func convertMoneyFrom(from: Budget, to: Budget, amount: Double) -> Double? {
        let converter = CurrencyConverter()
        return converter.convert(from: from.currency, to: to.currency, amount: amount)
    }

}
