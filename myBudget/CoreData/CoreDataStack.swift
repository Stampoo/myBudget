//
//  CoreDataStack.swift
//  myBudget
//
//  Created by fivecoil on 13/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import CoreData

final class CoreDataStack {

    //MARK: - Public properties

    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (description, error) in
        }
        return container
    }()

    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

}
