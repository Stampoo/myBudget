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
        if let index = isInStorage(budget: budget) {
            saveInStorage(budget: budget, index: index)
        } else {
            budgetList.append(budget)
            let encodedBudgetList = encodingBudgetList(budgetList: budgetList)
            storage.set(encodedBudgetList, forKey: Constants.budgetList)
        }
    }

    func saveBudgetList(budgetList: [Budget]) {
        let encodedBudgetList = encodingBudgetList(budgetList: budgetList)
        storage.set(encodedBudgetList, forKey: Constants.budgetList)
    }

    func delete(budget: Budget) -> (Int, Budget?) {
        var deletingBudget: (Int, Budget?) = (0, nil)
        var budgetList = openBudgetList()
        for oldBudget in budgetList {
            if oldBudget.name == budget.name,
                let index = budgetList.firstIndex(of: budget) {
                deletingBudget = (index, oldBudget)
                budgetList.remove(at: index)
                let encodedBudget = encodingBudgetList(budgetList: budgetList)
                storage.set(encodedBudget, forKey: Constants.budgetList)
            }
        }
        return deletingBudget
    }

    func budgetListWithout(budget: Budget) -> [Budget] {
        var currentBudgetList = openBudgetList()
        if let index = isInStorage(budget: budget) {
            currentBudgetList.remove(at: index)
        }
        return currentBudgetList
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

    private func saveInStorage(budget: Budget, index: Int) {
        if let currentIndex = isInStorage(budget: budget) {
            let (_, _) = delete(budget: budget)
            save(budget: budget, index: currentIndex)
        } else {
            save(budget: budget, index: index)
        }
    }

    private func isInStorage(budget: Budget) -> Int? {
        let budgetList = openBudgetList()
        if let index = budgetList.firstIndex(of: budget) {
            return index
        }
        return nil
    }

    private func save(budget: Budget, index: Int) {
        var budgetList = openBudgetList()
        budgetList.insert(budget, at: index)
        let encodingBudget = encodingBudgetList(budgetList: budgetList)
        storage.set(encodingBudget, forKey: Constants.budgetList)
    }
    
}
