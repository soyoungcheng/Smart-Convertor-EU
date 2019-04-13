//
//  AboutVC.swift
//  Smart Convertor EU
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    let mainView            = ShadowView()
    let developerInfoLabel  = MainLabel(text: "Developed by IOCode, iOS Developer Uladzislau Daratsiuk", textAligment: .center, numberOfLines: 3)
    let infoLabel           = MainLabel(text: "All currency data is sourced from the European Central Bank and updated daily at around 4:00pm CET.", textAligment: .center, numberOfLines: 5)
    let emailButton         = ActionButton()
    let privacyButton       = MainButton(text: "Privacy Policy")
    
    
    fileprivate func setupVIew(){
        view.addSubview(mainView)
        mainView.addSubview(developerInfoLabel)
        mainView.addSubview(infoLabel)
        mainView.addSubview(emailButton)
        mainView.addSubview(privacyButton)
        
        emailButton.setImage(UIImage(named: "email"), for: .normal)
        emailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(handlePrivacy), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            developerInfoLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            developerInfoLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            developerInfoLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            developerInfoLabel.heightAnchor.constraint(equalToConstant: 50),

            infoLabel.topAnchor.constraint(equalTo: developerInfoLabel.bottomAnchor, constant: 20),
            infoLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            infoLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            infoLabel.bottomAnchor.constraint(equalTo: emailButton.topAnchor, constant: -40),
            
            emailButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            emailButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            emailButton.heightAnchor.constraint(equalToConstant: 45),
            emailButton.widthAnchor.constraint(equalToConstant: 45),
            
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            privacyButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            privacyButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
            privacyButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
            privacyButton.heightAnchor.constraint(equalToConstant: 35),
            
            ])
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage                 = UIImage()
        navigationItem.title                                            = .titleAbout
        navigationController?.navigationBar.prefersLargeTitles          = true
        navigationController?.navigationBar.isTranslucent               = false
        navigationController?.navigationBar.barTintColor                = UIColor(named: "background")
        navigationController?.navigationBar.largeTitleTextAttributes    = [.foregroundColor: UIColor.darkGray, .font: UIFont(name: "AppleSDGothicNeo-Light", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes         = [.foregroundColor: UIColor.darkGray,.font: UIFont(name: "AppleSDGothicNeo-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.rightBarButtonItem                               = UIBarButtonItem(image: UIImage(named:"share"), style: .plain, target: self, action: #selector(handleShare))
        navigationController?.navigationBar.tintColor                   = UIColor(named: "system")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVIew()
        setupNavBar()
    }

}
