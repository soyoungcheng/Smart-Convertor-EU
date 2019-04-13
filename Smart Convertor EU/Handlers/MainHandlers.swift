//
//  MainHandlers.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 8/28/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC {
    @objc public func handleMenu(){
        if (menuShowing){
            UIView.animate(withDuration: 0.3) {
                self.heightAnchor?.isActive = false
                self.heightAnchor           = self.menuGlassView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                self.heightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.heightAnchor?.isActive = false
                self.heightAnchor           = self.menuGlassView.bottomAnchor.constraint(equalTo: self.view.topAnchor)
                self.heightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }) { (true) in
            }
        }
        menuShowing = !menuShowing
    }
    
    @objc public func finishedWithInput (){
        view.endEditing(true)
    }
    
    @objc public func handleUpdate(){
        loadRates(currency: currenntCurrency)
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
                            self.currentCurrencyForShape.text = json.base
                            self.dateLabel.text = "Last update: \(json.date)"
                            self.currentCurrencyLabel.text = "Current currency: \(json.base)"
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
    

    @objc public func handleInput(){
        rateCollection.reloadData()
    }
    
    @objc public func handleSelect(){
        let selectVC = UINavigationController(rootViewController: SelectCurrencyVC())
        selectVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(selectVC, animated: true, completion: nil)
    }
    
    public func generateMenuList() -> [Menu]{
        var array = [Menu]()
        
        let item1 = Menu(title: "Nearest exchange point", vc: NavigationVC())
        let item2 = Menu(title: "Tutorials", vc: TutorialVC())
        let item3 = Menu(title: "About", vc: AboutVC())
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        
        return array
    }

}
