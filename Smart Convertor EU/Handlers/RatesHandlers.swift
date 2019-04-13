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
    
    @objc public func handleUpdate(){
        loadRates(currency: currentCurrency)
    }
    
    @objc public func loadRates(currency: String){
        let urlBased = "http://api.openrates.io/latest?base=\(currency)"
        guard let url = URL(string: urlBased) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                }
                else{
                    if data != nil{
                        do{
                            self.rates.removeAll()
                            let json = try JSONDecoder().decode(CurrencyData.self, from: data!)
                            for (key, value) in json.rates {
                                self.rates.append(Rate(currency: key, rate: value))
                            }
                            self.loadHistoryRates(currency: currency, date: self.getYesterdayDate())
                        }
                        catch{
                            print(error)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    @objc public func loadHistoryRates(currency: String, date: String){
        let urlBased = "http://api.openrates.io/\(date)?base=\(currency)"
        print(urlBased)
        guard let url = URL(string: urlBased) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                }
                else{
                    if data != nil{
                        do{
                            self.ratesHistory.removeAll()
                            let json = try JSONDecoder().decode(CurrencyData.self, from: data!)
                            for (key, value) in json.rates {
                                self.ratesHistory.append(Rate(currency: key, rate: value))
                            }
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                if self.ratesHistory.isEmpty{
                    self.loadRates(currency: currency)
                }else{
                    self.rateCollection.reloadData()
                }
            }
        }
        task.resume()
    }
    
    func getYesterdayDate()  -> String {
        let yesterday               = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd"
        let date                    = dateFormatter.string(from: yesterday!)
        return date
    }
    
}
