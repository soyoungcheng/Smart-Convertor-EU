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
    let cellId = "cellId"
    var rates = [Rate]()
    var filtredResults = [Rate]()
    var selectedCurrencyObserver: NSObjectProtocol?
    var currenntCurrency: String = "EUR"
    let menuCellId = "menuCellId"
    var menuShowing = true
    var heightAnchor: NSLayoutConstraint?
    var menuList = [Menu]()
    
    lazy var menuGlassView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var menuTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: menuCellId)
        table.backgroundColor = UIColor.white.withAlphaComponent(0)
        table.separatorStyle = .none
        return table
    }()
    
    lazy var rateCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(RateCell.self, forCellWithReuseIdentifier: cellId)
        view.backgroundColor = UIColor(named: "background")?.withAlphaComponent(1)
        view.isScrollEnabled = true
        return view
    }()
    
    lazy var versionLabel = MainSmallLabel(text: "Version 1", textAligment: .center, numberOfLines: 1)
    
    let shapeView = ShapeView()
    let firstContainerView = ShadowView()
    lazy var dateLabel = MainSmallLabel(text: "Last update: Unknown", textAligment: .left, numberOfLines: 1)
    lazy var currentCurrencyLabel = MainSmallLabel(text: "Currenet currency: Unknown", textAligment: .right, numberOfLines: 1)
    lazy var currentCurrencyForShape = MainLabel(text: "Unknown", textAligment: .center, numberOfLines: 1)
    lazy var noDataLabel = MainSmallLabel(text: "You are offline or there is no data to display", textAligment: .center, numberOfLines: 2)
    
    lazy var mainTextField: UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont(name: .liteFont, size: .mainTextSize)
        tf.placeholder = "Enter amount"
        tf.layer.borderWidth = 0.5
        tf.layer.borderColor = UIColor.mainTextColor.cgColor.copy(alpha: 0.5)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 5
        tf.addTarget(self, action: #selector(handleInput), for: .allEditingEvents)
        return tf
    }()
    
    
    lazy var selectCurrency: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: .liteFont, size: .mainTextSize)
        button.setTitle("Select currency", for: .normal)
        button.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(named: "system")
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
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.finishedWithInput))
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
        
        menuGlassView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuGlassView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuGlassView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        heightAnchor = menuGlassView.bottomAnchor.constraint(equalTo: view.topAnchor)
        heightAnchor?.isActive = true
        
        menuTable.centerXAnchor.constraint(equalTo: menuGlassView.centerXAnchor).isActive = true
        menuTable.centerYAnchor.constraint(equalTo: menuGlassView.centerYAnchor).isActive = true
        menuTable.topAnchor.constraint(equalTo: menuGlassView.topAnchor, constant: 20).isActive = true
        menuTable.leftAnchor.constraint(equalTo: menuGlassView.leftAnchor).isActive = true
        menuTable.rightAnchor.constraint(equalTo: menuGlassView.rightAnchor).isActive = true
        menuTable.bottomAnchor.constraint(equalTo: versionLabel.topAnchor, constant: 10).isActive = true
        
        versionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        versionLabel.centerXAnchor.constraint(equalTo: menuGlassView.centerXAnchor).isActive = true
        versionLabel.leftAnchor.constraint(equalTo: menuGlassView.leftAnchor).isActive = true
        versionLabel.rightAnchor.constraint(equalTo: menuGlassView.rightAnchor).isActive = true
        versionLabel.bottomAnchor.constraint(equalTo: menuGlassView.bottomAnchor, constant: -10).isActive = true
        
        noDataLabel.isHidden = true
        
        noDataLabel.centerXAnchor.constraint(equalTo: rateCollection.centerXAnchor).isActive = true
        noDataLabel.centerYAnchor.constraint(equalTo: rateCollection.centerYAnchor).isActive = true
        noDataLabel.leftAnchor.constraint(equalTo: rateCollection.leftAnchor).isActive = true
        noDataLabel.rightAnchor.constraint(equalTo: rateCollection.rightAnchor).isActive = true
        noDataLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        currentCurrencyForShape.font = UIFont(name: .liteFont, size: 25)
        shapeView.topAnchor.constraint(equalTo: view.topAnchor ).isActive = true
        shapeView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shapeView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shapeView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        currentCurrencyForShape.heightAnchor.constraint(equalToConstant: 30).isActive = true
        currentCurrencyForShape.leftAnchor.constraint(equalTo: shapeView.leftAnchor).isActive = true
        currentCurrencyForShape.rightAnchor.constraint(equalTo: shapeView.rightAnchor).isActive = true
        currentCurrencyForShape.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor).isActive = true
        currentCurrencyForShape.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor).isActive = true
        
        firstContainerView.topAnchor.constraint(equalTo: shapeView.bottomAnchor,constant: 0).isActive = true
        firstContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        firstContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        firstContainerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: firstContainerView.topAnchor,constant: 5).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: firstContainerView.leftAnchor,constant: 10).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: firstContainerView.centerXAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        currentCurrencyLabel.topAnchor.constraint(equalTo: firstContainerView.topAnchor,constant: 5).isActive = true
        currentCurrencyLabel.leftAnchor.constraint(equalTo: firstContainerView.centerXAnchor,constant: 0).isActive = true
        currentCurrencyLabel.rightAnchor.constraint(equalTo: firstContainerView.rightAnchor, constant: -10).isActive = true
        currentCurrencyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        mainTextField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 10).isActive = true
        mainTextField.leftAnchor.constraint(equalTo: firstContainerView.leftAnchor,constant: 10).isActive = true
        mainTextField.rightAnchor.constraint(equalTo: firstContainerView.rightAnchor,constant: -10).isActive = true
        mainTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        selectCurrency.topAnchor.constraint(equalTo: mainTextField.bottomAnchor,constant: 20).isActive = true
        selectCurrency.leftAnchor.constraint(equalTo: firstContainerView.leftAnchor,constant: 10).isActive = true
        selectCurrency.rightAnchor.constraint(equalTo: firstContainerView.rightAnchor, constant: -10).isActive = true
        selectCurrency.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        rateCollection.topAnchor.constraint(equalTo: firstContainerView.bottomAnchor,constant: 10).isActive = true
        rateCollection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rateCollection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        rateCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 1).isActive = true
        rateCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupView()
        loadRates(currency: currenntCurrency)
        rateCollection.delegate = self
        rateCollection.dataSource = self
        menuTable.delegate = self
        menuTable.dataSource = self
        mainTextField.delegate = self
        menuList = generateMenuList()
        selectedCurrencyObserver = NotificationCenter.default.addObserver(forName: .selectedCurrency, object: nil, queue: OperationQueue.main, using: { (notification) in
            let selectVc = notification.object as! SelectCurrencyVC
            self.currenntCurrency = selectVc.selectedCurrency!
            self.loadRates(currency: self.currenntCurrency)
        })
    }
}
