//
//  TutorialVC.swift
//  Smart Convertor EU
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {
    
    let mainScrollView = MainScrollView()
    let firstTutorialImage = MainImageView(imageName: "tutorial1")
    let firstTutorialLabel = MainLabel(text: "To get result just select currency and enter amount", textAligment: .left, numberOfLines: 3)
    let secondTutorialLabel = MainLabel(text: "To get details about rates for one the currencies just press on one of them", textAligment: .right, numberOfLines: 3)
    let secondTutorialImage = MainImageView(imageName: "tutorial3")
    
    fileprivate func setupVIew(){
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(firstTutorialLabel)
        mainScrollView.addSubview(firstTutorialImage)
        mainScrollView.addSubview(secondTutorialLabel)
        mainScrollView.addSubview(secondTutorialImage)
        style(view: firstTutorialImage)
        style(view: secondTutorialImage)
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        firstTutorialLabel.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 20).isActive = true
        firstTutorialLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        firstTutorialLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        firstTutorialLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        firstTutorialImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        firstTutorialImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        firstTutorialImage.topAnchor.constraint(equalTo: firstTutorialLabel.bottomAnchor, constant: 20).isActive = true
        firstTutorialImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        secondTutorialLabel.topAnchor.constraint(equalTo: firstTutorialImage.bottomAnchor, constant: 20).isActive = true
        secondTutorialLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        secondTutorialLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        secondTutorialLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        secondTutorialImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        secondTutorialImage.widthAnchor.constraint(equalToConstant: 140).isActive = true
        secondTutorialImage.topAnchor.constraint(equalTo: secondTutorialLabel.bottomAnchor, constant: 20).isActive = true
        secondTutorialImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = .titleTutorial
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray, .font: UIFont(name: "AppleSDGothicNeo-Light", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray,.font: UIFont(name: "AppleSDGothicNeo-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.tintColor = UIColor(named: "system")
    }
    
    fileprivate func style(view: UIImageView) {
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVIew()
        setupNavBar()
    }


}
