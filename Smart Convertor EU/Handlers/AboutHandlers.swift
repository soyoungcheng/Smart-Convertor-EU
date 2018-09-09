//
//  AboutHandlers.swift
//  Smart Convertor EU
//
//  Created by Uladzislau Daratsiuk on 9/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension AboutVC {
    @objc public func handleShare(){
        let mainVC = UIActivityViewController(activityItems: ["Take a look at this amazing app. which can convert different currencies, it's called 'Smart Currency'"], applicationActivities: nil)
        mainVC.popoverPresentationController?.sourceView = self.view
        self.present(mainVC, animated: true, completion: nil)
    }
    
    @objc public func handlePrivacy(){
        guard let url = URL(string: "https://github.com/ula1990/Smart-Convertor-EU/blob/master/README.md") else {return}
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
