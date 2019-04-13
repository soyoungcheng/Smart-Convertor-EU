//
//  MainVC.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 8/28/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

var currencyForDetails: String?

class MainVC: UIViewController {
    let cellId                      = "cellId"
    var rates                       = [Rate]()
    var filtredResults              = [Rate]()
    var menuList                    = [Menu]()
    var currenntCurrency: String    = "EUR"
    let menuCellId                  = "menuCellId"
    var menuShowing                 = true
    
    var heightAnchor: NSLayoutConstraint?
    var selectedCurrencyObserver: NSObjectProtocol?

    lazy var menuGlassView: UIView = {
        let view                                        = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor                            = UIColor.white.withAlphaComponent(0.9)
        view.clipsToBounds                              = true
        view.layer.cornerRadius                         = 2
        return view
    }()
    
    lazy var menuTable: UITableView = {
        let table                                       = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: menuCellId)
        table.backgroundColor                           = UIColor.white.withAlphaComponent(0)
        table.separatorStyle                            = .none
        return table
    }()
    
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
        view.register(RateCell.self, forCellWithReuseIdentifier: cellId)
        return view
    }()
    
    lazy var versionLabel               = MainSmallLabel(text: "Version 1", textAligment: .center, numberOfLines: 1)
    let shapeView                       = ShapeView()
    let firstContainerView              = ShadowView()
    lazy var dateLabel                  = MainSmallLabel(text: "Last update: Unknown", textAligment: .left, numberOfLines: 1)
    lazy var currentCurrencyLabel       = MainSmallLabel(text: "Currenet currency: Unknown", textAligment: .right, numberOfLines: 1)
    lazy var currentCurrencyForShape    = MainLabel(text: "Unknown", textAligment: .center, numberOfLines: 1)
    lazy var noDataLabel                = MainSmallLabel(text: "You are offline or there is no data to display", textAligment: .center, numberOfLines: 2)
    
    lazy var mainTextField: UITextField = {
       let tf                                           = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints    = false
        tf.font                                         = UIFont(name: .liteFont, size: .mainTextSize)
        tf.placeholder                                  = "Enter amount"
        tf.layer.borderWidth                            = 0.5
        tf.layer.borderColor                            = UIColor.mainTextColor.cgColor.copy(alpha: 0.5)
        tf.textAlignment                                = .center
        tf.layer.cornerRadius                           = 5
        tf.addTarget(self, action: #selector(handleInput), for: .allEditingEvents)
        return tf
    }()
    
    
    lazy var selectCurrency: UIButton = {
        let button                                          = UIButton()
        button.translatesAutoresizingMaskIntoConstraints    = false
        button.titleLabel?.textAlignment                    = .center
        button.titleLabel?.font                             = UIFont(name: .liteFont, size: .mainTextSize)
        button.contentMode                                  = .scaleAspectFill
        button.clipsToBounds                                = true
        button.layer.cornerRadius                           = 5
        button.backgroundColor                              = UIColor(named: "system")
        button.setTitle("Select currency", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = .titleText
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray, .font: UIFont(name: "AppleSDGothicNeo-Light", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray,.font: UIFont(name: "AppleSDGothicNeo-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"update"), style: .plain, target: self, action: #selector(handleUpdate))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(handleMenu))
        navigationController?.navigationBar.tintColor = UIColor(named: "system")
    }
    
    fileprivate func toolBarSetup() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.finishedWithInput))
        doneButton.tintColor = .black
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        mainTextField.inputAccessoryView = toolBar
    }
    
    fileprivate func setupView(){
        view.addSubview(shapeView)
        shapeView.addSubview(currentCurrencyForShape)
        view.addSubview(firstContainerView)
        view.addSubview(rateCollection)
        rateCollection.addSubview(noDataLabel)
        firstContainerView.addSubview(mainTextField)
        firstContainerView.addSubview(selectCurrency)
        firstContainerView.addSubview(dateLabel)
        firstContainerView.addSubview(currentCurrencyLabel)
        view.addSubview(menuGlassView)
        menuGlassView.addSubview(menuTable)
        menuGlassView.addSubview(versionLabel)
        
        heightAnchor                    = menuGlassView.bottomAnchor.constraint(equalTo: view.topAnchor)
        heightAnchor?.isActive          = true
        noDataLabel.isHidden            = true
        currentCurrencyForShape.font    = UIFont(name: .liteFont, size: 25)
        
        NSLayoutConstraint.activate([
            menuGlassView.leftAnchor.constraint(equalTo: view.leftAnchor),
            menuGlassView.rightAnchor.constraint(equalTo: view.rightAnchor),
            menuGlassView.topAnchor.constraint(equalTo: view.topAnchor),

            menuTable.topAnchor.constraint(equalTo: menuGlassView.topAnchor, constant: 20),
            menuTable.leftAnchor.constraint(equalTo: menuGlassView.leftAnchor),
            menuTable.rightAnchor.constraint(equalTo: menuGlassView.rightAnchor),
            menuTable.bottomAnchor.constraint(equalTo: versionLabel.topAnchor, constant: 10),

            versionLabel.heightAnchor.constraint(equalToConstant: 50),
            versionLabel.leftAnchor.constraint(equalTo: menuGlassView.leftAnchor),
            versionLabel.rightAnchor.constraint(equalTo: menuGlassView.rightAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: menuGlassView.bottomAnchor, constant: -10),

            noDataLabel.centerYAnchor.constraint(equalTo: rateCollection.centerYAnchor),
            noDataLabel.leftAnchor.constraint(equalTo: rateCollection.leftAnchor),
            noDataLabel.rightAnchor.constraint(equalTo: rateCollection.rightAnchor),
            noDataLabel.heightAnchor.constraint(equalToConstant: 20),

            shapeView.topAnchor.constraint(equalTo: view.topAnchor ),
            shapeView.leftAnchor.constraint(equalTo: view.leftAnchor),
            shapeView.rightAnchor.constraint(equalTo: view.rightAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 130),

            currentCurrencyForShape.heightAnchor.constraint(equalToConstant: 30),
            currentCurrencyForShape.leftAnchor.constraint(equalTo: shapeView.leftAnchor),
            currentCurrencyForShape.rightAnchor.constraint(equalTo: shapeView.rightAnchor),
            currentCurrencyForShape.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor),

            firstContainerView.topAnchor.constraint(equalTo: shapeView.bottomAnchor,constant: 0),
            firstContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            firstContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            firstContainerView.heightAnchor.constraint(equalToConstant: 140),

            dateLabel.topAnchor.constraint(equalTo: firstContainerView.topAnchor,constant: 5),
            dateLabel.leftAnchor.constraint(equalTo: firstContainerView.leftAnchor,constant: 10),
            dateLabel.rightAnchor.constraint(equalTo: firstContainerView.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),

            currentCurrencyLabel.topAnchor.constraint(equalTo: firstContainerView.topAnchor,constant: 5),
            currentCurrencyLabel.leftAnchor.constraint(equalTo: firstContainerView.centerXAnchor,constant: 0),
            currentCurrencyLabel.rightAnchor.constraint(equalTo: firstContainerView.rightAnchor, constant: -10),
            currentCurrencyLabel.heightAnchor.constraint(equalToConstant: 20),

            mainTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 10),
            mainTextField.leftAnchor.constraint(equalTo: firstContainerView.leftAnchor,constant: 10),
            mainTextField.rightAnchor.constraint(equalTo: firstContainerView.rightAnchor,constant: -10),
            mainTextField.heightAnchor.constraint(equalToConstant: 35),

            selectCurrency.topAnchor.constraint(equalTo: mainTextField.bottomAnchor,constant: 20),
            selectCurrency.leftAnchor.constraint(equalTo: firstContainerView.leftAnchor,constant: 10),
            selectCurrency.rightAnchor.constraint(equalTo: firstContainerView.rightAnchor, constant: -10),
            selectCurrency.heightAnchor.constraint(equalToConstant: 35),

            rateCollection.topAnchor.constraint(equalTo: firstContainerView.bottomAnchor,constant: 5),
            rateCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            rateCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            rateCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 1),
            
            ])
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        menuList                    = generateMenuList()
        menuTable.delegate          = self
        menuTable.dataSource        = self
        setupNavBar()
        setupView()
        toolBarSetup()
        loadRates(currency: currenntCurrency)
        
        rateCollection.delegate     = self
        rateCollection.dataSource   = self
        mainTextField.delegate      = self
        
        mainTextField.returnKeyType = UIReturnKeyType.done
        selectedCurrencyObserver    = NotificationCenter.default.addObserver(forName: .selectedCurrency, object: nil, queue: OperationQueue.main, using: { (notification) in
            let selectVc            = notification.object as! SelectCurrencyVC
            self.currenntCurrency   = selectVc.selectedCurrency!
            self.loadRates(currency: self.currenntCurrency)
        })
    }
}
