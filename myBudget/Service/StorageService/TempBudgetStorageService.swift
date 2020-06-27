//
//  TempBudgetStorageService.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class TempBudgetStorageService {
    
    //MARK: - Constants
    
    private enum Constants {
        static let budgetList = "BudgetList"
    }
    
    //MARK: - Public properties
    
    static let shared = TempBudgetStorageService()
    
    //MARK: - Private properties
    
    private let storage = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    
    //MARK: - Public methods
    
    func openBudgetList() -> [Budget] {
        guard let budgetList = storage.value(forKey: Constants.budgetList) as? [Data] else {
            return []
        }
        let decodedBudgetList = decodingBudgetList(data: budgetList)
        return decodedBudgetList
    }
    
    func addBudgetInList(budget: Budget) {
        var budgetList = openBudgetList()
        budgetList.append(budget)
        let encodedBudgetList = encodingBudgetList(budgetList: budgetList)
        storage.set(encodedBudgetList, forKey: Constants.budgetList)
    }
    
    
    //MARK: - Private methods
    
    private func encodingBudgetList(budgetList: [Budget]) -> [Data] {
        var encodedBudgetList = [Data]()
        for budget in budgetList {
            guard let encodedBudget = try? encoder.encode(budget) else {
                break
            }
            encodedBudgetList.append(encodedBudget)
        }
        return encodedBudgetList
    }
    
    private func decodingBudgetList(data: [Data]) -> [Budget] {
        var decodedBudgetList = [Budget]()
        for budget in data {
            guard let decodedBudget = try? decoder.decode(Budget.self, from: budget) else {
                break
            }
            decodedBudgetList.append(decodedBudget)
        }
        return decodedBudgetList
    }
    
}
