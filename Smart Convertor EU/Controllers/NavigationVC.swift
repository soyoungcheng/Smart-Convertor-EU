//
//  NavigationVC.swift
//  Smart Convertor EU
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NavigationVC: UIViewController {

    let manager  = CLLocationManager()
    let request  = MKLocalSearchRequest()
    let mainView = ShadowView()
    
    lazy var mapView: MKMapView = {
       let view                                         = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.clipsToBounds                              = true
        view.layer.cornerRadius                         = 14
        return view
    }()
    
    fileprivate func setupVIew(){
        view.addSubview(mainView)
        mainView.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            mapView.leftAnchor.constraint(equalTo: mainView.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: mainView.rightAnchor),
            mapView.topAnchor.constraint(equalTo: mainView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            ])
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage                 = UIImage()
        navigationItem.title                                            = .titleNavi
        navigationController?.navigationBar.prefersLargeTitles          = true
        navigationController?.navigationBar.isTranslucent               = false
        navigationController?.navigationBar.barTintColor                = UIColor(named: "background")
        navigationController?.navigationBar.largeTitleTextAttributes    = [.foregroundColor: UIColor.darkGray, .font: UIFont(name: "AppleSDGothicNeo-Light", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes         = [.foregroundColor: UIColor.darkGray,.font: UIFont(name: "AppleSDGothicNeo-Light", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.tintColor                   = UIColor(named: "system")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor        = .white
        setupVIew()
        setupNavBar()
        manager.delegate            = self
        manager.desiredAccuracy     =   kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

}
