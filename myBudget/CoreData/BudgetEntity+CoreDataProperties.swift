//
//  BudgetEntity+CoreDataProperties.swift
//  myBudget
//
//  Created by fivecoil on 14/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//
//

import Foundation
import CoreData


extension BudgetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetEntity> {
        return NSFetchRequest<BudgetEntity>(entityName: "BudgetEntity")
    }

    @NSManaged public var budget: Data?

}
