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
    var request: HTTPRequest { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HTTPRequest {
    case request
    case requestWithBodyAndParameters([String: Any], [String: String])
}

enum FixerAPI {
    case getActualCurrency(String, String)
}

extension FixerAPI: Router {

    //MARK: - Constants

    private enum Constants {
        static let basicURL = "http://data.fixer.io/api/"
    }


    //MARK: - Public properties

    var baseURL: String {
        return Constants.basicURL
    }

    var path: String {
        let key = "f10db5b8439d9f80397cb6aedaa403af"
        switch self {
        case let .getActualCurrency(atCurrency, forCurrency):
            return "latest?access_key=\(key)&base=\(atCurrency)&symbols=\(forCurrency)"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var request: HTTPRequest {
        return .request
    }

}
