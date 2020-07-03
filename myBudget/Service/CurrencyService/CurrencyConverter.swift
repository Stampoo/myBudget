//
//  CurrencyConverter.swift
//  myBudget
//
//  Created by fivecoil on 01/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class CurrencyConverter {


    //MARK: - Private properties

    private let networkManager = NetworkManager()
    private let storage = UserDefaults.standard


    //MARK: - Public methods

    func convert(from: Currency, to: Currency, amount: Double) -> Double? {
        guard let fromRate = storage.value(forKey: from.rawValue) as? Double,
            let toRate = storage.value(forKey: to.rawValue) as? Double else {
            return nil
        }
        return toRate / fromRate * amount
    }

    func updateRates() {
        for currency in Currency.allCases {
            saveRatesInStorage(savedCurrency: currency)
        }
    }

    //MARK: - Private methods

    private func saveRatesInStorage(savedCurrency: Currency) {
        getCurrencyToEuro(currency: savedCurrency, completion: {(currency) in
            guard let multiplier = self.searchResult(from: currency.rates) else {
                return
            }
            self.storage.set(multiplier, forKey: savedCurrency.rawValue)
        })
    }

    private func getCurrencyToEuro(currency: Currency, completion: @escaping (CurrencyRate) -> Void) {
        networkManager.getActualCurrency(at: "EUR", forCurrency: currency.rawValue, completion: completion)
    }

    private func searchResult(from rates: Rates?) -> Double? {
        let rateArray = [
            rates?.BYN,
            rates?.EUR,
            rates?.RUB,
            rates?.USD
        ]

        for rate in rateArray {
            if let unwrapRate = rate {
                return unwrapRate
            }
        }
        return nil
    }

}
