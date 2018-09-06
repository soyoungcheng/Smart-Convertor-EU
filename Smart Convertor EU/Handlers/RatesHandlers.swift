//
//  RatesHandlers.swift
//  Smart Convertor EU
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension RatesVC {
    
    @objc public func loadRates(currency: String){
        let urlBased = "http://api.openrates.io/latest?base=\(currency)"
        guard let url = URL(string: urlBased) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    //                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                }
                else{
                    if data != nil{
                        do{
                            self.rates.removeAll()
                            let json = try JSONDecoder().decode(CurrencyData.self, from: data!)
                            for (key, value) in json.rates {
                                self.rates.append(Rate(currency: key, rate: value))
                            }
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                self.rateCollection.reloadData()
            }
        }
        task.resume()
    }
}
