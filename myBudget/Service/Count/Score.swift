//
//  Count.swift
//  myBudget
//
//  Created by fivecoil on 26/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class Score {
    
    //MARK: - Constants
    
    private enum Constants {
        static let budget = "My budget"
    }
    
    //MARK: - Private properties
    
    private var name: String
    private var concurrency: Currency
    private var allCount: Double
    
    
    //MARK: - Initializators
    
    init(name: String, concurrency: Currency, allCount: Double){
        self.name = name.isEmpty ? Constants.budget : name
        self.concurrency = concurrency
        self.allCount = allCount
    }
}
