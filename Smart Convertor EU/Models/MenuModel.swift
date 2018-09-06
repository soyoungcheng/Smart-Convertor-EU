//
//  MenuModel.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 8/2/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Menu {
    var title: String?
    var vc: UIViewController?
    
    init(title: String, vc: UIViewController) {
        self.title = title
        self.vc = vc
    }
}
