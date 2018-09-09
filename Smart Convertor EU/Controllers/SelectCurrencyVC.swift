//
//  SelectCurrencyVC.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class SelectCurrencyVC: UIViewController {

    var selectedCurrency: String?
    var currencies = ["PHP","THB","TRY","SEK","CNY","PLN","AUD","RUB","SGD","INR","DKK","CHF","MYR","HKD","EUR","NOK","MXN","NZD","ZAR","HUF","HRK","BGN","KRW","CAD","GBP","ILS","RON","BRL","ISK","CZK","JPY","IDR"]
    
    let containerView = ShadowView()
    let pickerView    = MainPickerView()
    let doneButton    = MainButton(text: "Confirm")
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        setupNavBar()
        setupView()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(containerView)
        view.addSubview(doneButton)
        
        containerView.addSubview(pickerView)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        pickerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        pickerView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        pickerView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        doneButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10).isActive = true
        doneButton.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        doneButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        doneButton.addTarget(self, action: #selector(handleDismiss), for: .allEvents)
    }

}
