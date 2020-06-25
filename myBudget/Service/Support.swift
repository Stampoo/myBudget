//
//  Support.swift
//  myBudget
//
//  Created by fivecoil on 25/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

protocol Router {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

