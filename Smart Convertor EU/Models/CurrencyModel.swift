//
//  CurrencyModel.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 9/3/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class CurrencyData: Decodable {
    let base: String
    let date: String
    let rates: [String: Double]
    
    init(base: String, date: String, rates: [String: Double]) {
        self.base = base
        self.date = date
        self.rates = rates
    }
}

class Rate {
    let currency: String
    let rate: Double
    
    init(currency: String, rate: Double) {
        self.currency = currency
        self.rate = rate
    }
}
