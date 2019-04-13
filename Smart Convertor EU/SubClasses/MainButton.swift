//
//  ActionButton.swift
//  Leeroy Crew
//
//  Created by Uladzislau Daratsiuk on 7/17/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainButton: UIButton {

    init(text: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints  = false
        self.clipsToBounds                              = true
        self.contentMode                                = .scaleAspectFill
        self.setTitle(text, for: .normal)
        self.titleLabel?.textAlignment                  = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font                           = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        self.layer.cornerRadius                         = 5
        self.backgroundColor                            = UIColor(named: "system")
        self.tintColor                                  = .white
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
