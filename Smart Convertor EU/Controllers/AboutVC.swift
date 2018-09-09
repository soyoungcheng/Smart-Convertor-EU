//
//  AboutVC.swift
//  Smart Convertor EU
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    let mainView = ShadowView()
    let developerInfoLabel = MainLabel(text: "Developed by IOCode, iOS Developer Uladzislau Daratsiuk", textAligment: .center, numberOfLines: 3)
    let emailButton = ActionButton()
    
    fileprivate func setupVIew(){
        view.addSubview(mainView)
        mainView.addSubview(developerInfoLabel)
        mainView.addSubview(emailButton)
        
        developerInfoLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20).isActive = true
        developerInfoLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        developerInfoLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20).isActive = true
        developerInfoLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20).isActive = true
        developerInfoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailButton.setImage(UIImage(named: "email"), for: .normal)
        emailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        emailButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        emailButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        emailButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        emailButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = .titleAbout
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray, .font: UIFont(name: "AppleSDGothicNeo-Light", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray,.font: UIFont(name: "AppleSDGothicNeo-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"share"), style: .plain, target: self, action: #selector(handleShare))
        navigationController?.navigationBar.tintColor = UIColor(named: "system")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVIew()
        setupNavBar()
    }

}
