//
//  SelectTypePicker.swift
//  Leeroy Crew
//
//  Created by Uladzislau Daratsiuk on 7/25/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class MainPickerView: UIPickerView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor                            = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints  = false
        self.layer.masksToBounds                        = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
