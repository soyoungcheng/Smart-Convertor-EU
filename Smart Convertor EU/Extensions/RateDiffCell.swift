//
//  RateCell.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class RateDiffCell: UICollectionViewCell {
    
    let flagImage       = MainImageView(imageName: "")
    let currencyName    = MainLabel(text: "", textAligment: .left, numberOfLines: 1)
    let currencyRate    = MainSmallLabel(text: "", textAligment: .left, numberOfLines: 1)
    let resultLabel     = MainLabel(text: "", textAligment: .right, numberOfLines: 1)
    
    fileprivate func setupView(){
        style(view: contentView)
        contentView.addSubview(flagImage)
        contentView.addSubview(currencyName)
        contentView.addSubview(currencyRate)
        contentView.addSubview(resultLabel)
        
        resultLabel.clipsToBounds       = true
        resultLabel.layer.cornerRadius  = 5
        resultLabel.textColor           = .white
        resultLabel.textAlignment       = .center
        
        NSLayoutConstraint.activate([
            
            flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            flagImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            flagImage.heightAnchor.constraint(equalToConstant: 35),
            flagImage.widthAnchor.constraint(equalToConstant: 35),
            
            currencyName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            currencyName.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            currencyName.leftAnchor.constraint(equalTo: flagImage.rightAnchor, constant: 20),
            currencyName.rightAnchor.constraint(equalTo: contentView.centerXAnchor),

            currencyRate.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            currencyRate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            currencyRate.leftAnchor.constraint(equalTo: flagImage.rightAnchor, constant: 20),
            currencyRate.rightAnchor.constraint(equalTo: contentView.centerXAnchor),

            resultLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            resultLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            resultLabel.heightAnchor.constraint(equalToConstant: 30),
            resultLabel.widthAnchor.constraint(equalToConstant: 50),
            
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func style(view: UIView) {
        view.layer.masksToBounds        = false
        view.backgroundColor            = .white
        view.layer.cornerRadius         = 14
        view.layer.shadowColor          = UIColor.black.cgColor
        view.layer.shadowOffset         = CGSize(width: 1, height: 5)
        view.layer.shadowRadius         = 8
        view.layer.shadowOpacity        = 0.2
        view.layer.shadowPath           = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
        view.layer.shouldRasterize      = true
        view.layer.rasterizationScale   = UIScreen.main.scale
    }
    
    public func updateData(rate: Rate, entery: Double, currentCurrency: String){
        currencyName.text   = "\(currentCurrency)/\(rate.currency)"
        currencyRate.text   = "Current rate: \(String(rate.rate))"
        flagImage.image     = UIImage(named: rate.currency)
        if entery == 0{
            resultLabel.text = ""
        }else{
            resultLabel.text = String(round((entery * rate.rate)*100)/100)
        }
        changeColorForLabel()
    }
    
  fileprivate func changeColorForLabel(){
        if resultLabel.text!.range(of:"-") != nil {
            resultLabel.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        }else{
            resultLabel.backgroundColor = UIColor(named: "positive")
        }
    }
    
}
