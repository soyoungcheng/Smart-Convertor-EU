//
//  RatesVC.swift
//  Smart Convertor EU
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class RatesVC: UIViewController {

    let cellId          = "cellId"
    var rates           = [Rate]()
    var filtredResults  = [Rate]()
    var currentCurrency: String = "EUR"
    var ratesHistory    = [Rate]()
    
    lazy var rateCollection: UICollectionView = {
        let layout                                      = UICollectionViewFlowLayout()
        let view                                        = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection                          = .vertical
        layout.sectionInset                             = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing                  = 10
        layout.minimumLineSpacing                       = 15
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor                            = UIColor(named: "background")?.withAlphaComponent(1)
        view.isScrollEnabled                            = true
        view.register(RateDiffCell.self, forCellWithReuseIdentifier: cellId)
        return view
    }()
    lazy var noDataLabel = MainSmallLabel(text: "You are offline or there is no data to display", textAligment: .center, numberOfLines: 2)
    
    fileprivate func setupVIew(){
        view.addSubview(rateCollection)
        rateCollection.addSubview(noDataLabel)
        
        noDataLabel.isHidden = true
        
        NSLayoutConstraint.activate([
            
            noDataLabel.centerYAnchor.constraint(equalTo: rateCollection.centerYAnchor),
            noDataLabel.leftAnchor.constraint(equalTo: rateCollection.leftAnchor),
            noDataLabel.rightAnchor.constraint(equalTo: rateCollection.rightAnchor),
            noDataLabel.heightAnchor.constraint(equalToConstant: 20),
            
            rateCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            rateCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            rateCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            rateCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            ])
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage                 = UIImage()
        navigationItem.title                                            = .titleRates
        navigationController?.navigationBar.prefersLargeTitles          = true
        navigationController?.navigationBar.isTranslucent               = false
        navigationController?.navigationBar.barTintColor                = UIColor(named: "background")
        navigationController?.navigationBar.largeTitleTextAttributes    = [.foregroundColor: UIColor.darkGray, .font: UIFont(name: "AppleSDGothicNeo-Light", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes         = [.foregroundColor: UIColor.darkGray,.font: UIFont(name: "AppleSDGothicNeo-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.tintColor                   = UIColor(named: "system")
        navigationItem.rightBarButtonItem                               = UIBarButtonItem(image: UIImage(named:"update"), style: .plain, target: self, action: #selector(handleUpdate))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor        = .white
        currentCurrency             = currencyForDetails!
        setupVIew()
        setupNavBar()
        rateCollection.delegate     = self
        rateCollection.dataSource   = self
        loadRates(currency: currentCurrency)

    }


}
