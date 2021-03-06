//
//  TempStorageService.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class TempHistoryStorageService {
    
    //MARK: - Types
    
    private enum ValueInStorage: String {
        case budgetList = "BudgetList"
        case settings = "Settings"
        case transactionHistory = "TransactionHistory"
    }
    
    
    //MARK: - Public properties
    
    static let shared = TempHistoryStorageService()
    
    
    //MARK: - Private properties
    
    private let storage = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    
    //MARK: - Public methods
    
    func openHistory(budget: Budget) -> [Transaction] {
        guard let history = storage.value(forKey: budget.name) as? [Data] else {
            return [Transaction]()
        }
        let decodedHistory = decodingTransaction(data: history)
        return decodedHistory
    }
    
    func addTransactionInHistory(budget: Budget, transaction: Transaction) {
        var history = openHistory(budget: budget)
        history.insert(transaction, at: 0)
        let encodedHistory = encodingTransaction(transactions: history)
        storage.set(encodedHistory, forKey: budget.name)
    }

    func replaceCurrentTransaction(at newTransaction: [Transaction], for budget: Budget) {
        deleteHistory(at: budget)
        saveHistory(at: budget, history: newTransaction)
    }

    func calculateSpent(budget: Budget) -> Double {
        var spent = 0.0
        let history = TempHistoryStorageService.shared.openHistory(budget: budget)
        history.forEach { spent += transactionRecognizing(transaction: $0) }
        return spent
    }

    func migrateHistoryAfterRename(from budget: Budget, toBudget: Budget) {
        let decodingHistory = openHistory(budget: budget)
        saveHistory(at: toBudget, history: decodingHistory)
        deleteHistory(at: budget)
    }


    //MARK: - Private methods
    
    private func encodingTransaction(transactions: [Transaction]) -> [Data] {
        var encodedTransactions = [Data]()
        for transaction in transactions {
            guard let encodedTransaction = try? encoder.encode(transaction) else {
                break
            }
            encodedTransactions.append(encodedTransaction)
        }
        return encodedTransactions
    }
    
    private func decodingTransaction(data: [Data]) -> [Transaction] {
        var decodedTransactions = [Transaction]()
        for transaction in data {
            guard let decodedTransaction = try? decoder.decode(Transaction.self, from: transaction) else {
                break
            }
            decodedTransactions.append(decodedTransaction)
        }
        return decodedTransactions
    }

    private func transactionRecognizing(transaction: Transaction) -> Double {
        -transaction.amount
    }

    private func deleteHistory(at budget: Budget) {
        storage.set(nil, forKey: budget.name)
    }

    private func saveHistory(at budget: Budget, history: [Transaction]) {
        let encodingHistory = encodingTransaction(transactions: history)
        storage.set(encodingHistory, forKey: budget.name)
    }

}
