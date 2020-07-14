//
//  StorageService.swift
//  myBudget
//
//  Created by fivecoil on 14/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import CoreData

final class StorageService {

    //MARK: - Private properties

    private let context = CoreDataStack.shared.context
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()



    //MARK: - Public methods

    func openBudgetList() -> [Budget] {
        let encodedBydgetList = pullDataFromContext()
        let decodedBudgetList = decodingBudgetList(data: encodedBydgetList)
        return decodedBudgetList
    }

    func save(budgetList: [Budget]) {
        let budgetEntity = BudgetEntity(context: context)
        let encodedBudgetList = encodingBudgetList(budgetList: budgetList)
        encodedBudgetList.forEach { budgetEntity.budget = $0 }
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

    private func pullDataFromContext() -> [Data] {
        let request = NSFetchRequest<BudgetEntity>(entityName: "BudgetEntity")
        let budgetEntity = try? context.fetch(request)
        if let budgetEntities = budgetEntity,
            !budgetEntities.isEmpty {
            var budgetList = [Data]()
            for budgetStorage in budgetEntities {
                if let budget = budgetStorage.budget {
                    budgetList.append(budget)
                }
            }
            return budgetList
        }
        return [Data]()
    }

}
