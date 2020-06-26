//
//  TempStorageService.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class TempStorageService {
    
    //MARK: - Types
    
    private enum ValueInStorage: String {
        case budgetList = "BudgetList"
        case settings = "Settings"
        case transactionHistory = "TransactionHistory"
    }
    
    
    //MARK: - Public properties
    
    static let shared = TempStorageService()
    
    
    //MARK: - Private properties
    
    private let storage = UserDefaults.standard
    private let encoder = JSONEncoder()
    
    
    //MARK: - Public methods
    
    
    //MARK: - Private methods
    
    private func openCurrentHistory() {
        storage.value(forKey: ValueInStorage.budgetList.rawValue)
    }
    
    private func encodingTransaction(transactions: [Transaction]) {
        var encodedTransactions = [Data]()
        for transaction in transactions {
            let encodedTransaction = try? encoder.encode(transaction)
        }
    }
    
}
