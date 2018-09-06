//
//  RateCell.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class RateDiffCell: UICollectionViewCell {
    
    let flagImage = MainImageView(imageName: "")
    let currencyName = MainLabel(text: "", textAligment: .left, numberOfLines: 1)
    let currencyRate = MainSmallLabel(text: "", textAligment: .left, numberOfLines: 1)
    let resulLabel = MainLabel(text: "", textAligment: .right, numberOfLines: 1)
    
    fileprivate func setupView(){
        style(view: contentView)
        contentView.addSubview(flagImage)
        contentView.addSubview(currencyName)
        contentView.addSubview(currencyRate)
        contentView.addSubview(resulLabel)
        
        flagImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        flagImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        flagImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
        flagImage.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        currencyName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        currencyName.bottomAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currencyName.leftAnchor.constraint(equalTo: flagImage.rightAnchor, constant: 20).isActive = true
        currencyName.rightAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        currencyRate.topAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        currencyRate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        currencyRate.leftAnchor.constraint(equalTo: flagImage.rightAnchor, constant: 20).isActive = true
        currencyRate.rightAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        resulLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        resulLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        resulLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        resulLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func style(view: UIView) {
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
    public func updateData(rate: Rate, entery: Double, currentCurrency: String){
        currencyName.text = "\(currentCurrency)/\(rate.currency)"
        currencyRate.text = "Current rate: \(String(rate.rate))"
        flagImage.image = UIImage(named: rate.currency)
        if entery == 0{
            resulLabel.text = ""
        }else{
            resulLabel.text = String(round((entery * rate.rate)*100)/100)
        }
        
    }
    
}
