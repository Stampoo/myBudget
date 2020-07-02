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
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue.global(qos: .utility)

    //MARK: - Public methods

    func getActualCurrency(at: String, forCurrency: String, completion: @escaping (CurrencyRate) -> Void) {
        let api = FixerAPI.getActualCurrency(at, forCurrency)
        guard let request = requestBuilder.calculateRequest(by: api) else {
            return
        }
        session.dataTask(with: request) { (data, _, _) in
            guard let data = data,
            let rate = try? self.decoder.decode(CurrencyRate.self, from: data) else {
                return
            }
            self.queue.async {
                completion(rate)
            }
        }.resume()
    }
}
