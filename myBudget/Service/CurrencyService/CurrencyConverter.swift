//
//  CurrencyConverter.swift
//  myBudget
//
//  Created by fivecoil on 01/07/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

final class CurrencyConverter {

    //MARK: - Types

    enum Currency: String {
        case USD = "USD"
        case bRuble = "BYN"
        case ruble = "RUB"
        case euro = "EUR"
    }


    //MARK: - Private properties

    private let networkManager = NetworkManager()


    //MARK: - Public methods

    func currencyRate(forCurrency: Currency, at: Currency) {
        networkManager.getActualCurrency(at: at.rawValue, forCurrency: forCurrency.rawValue)
    }

}
