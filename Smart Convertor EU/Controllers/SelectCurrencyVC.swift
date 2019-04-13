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
        pickerView.delegate     = self
        pickerView.dataSource   = self
        setupNavBar()
        setupView()
    }
    
    func setupView(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(containerView)
        view.addSubview(doneButton)
        
        containerView.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            containerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70),
            containerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            containerView.heightAnchor.constraint(equalToConstant: 160),
            
            pickerView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            pickerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            doneButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            doneButton.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            doneButton.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 35),
            
            ])
        
        doneButton.addTarget(self, action: #selector(handleDismiss), for: .allEvents)
    }
    
    @objc fileprivate func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }

}
