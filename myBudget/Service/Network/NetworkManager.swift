//
//  NetworkManager.swift
//  myBudget
//
//  Created by fivecoil on 30/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation


final class NetworkManager {

    //MARK: - Private properties

    private let session = URLSession(configuration: .default)
    private let requestBuilder = RequestBuilder()

    //MARK: - Public methods

    func getActualCurrency(at: String, forCurrency: String) {
        let api = FixerAPI.getActualCurrency(at, forCurrency)
        guard let request = requestBuilder.calculateRequest(by: api) else {
            return
        }
        session.dataTask(with: request) { (data, responce, error) in
            
        }
    }
}
