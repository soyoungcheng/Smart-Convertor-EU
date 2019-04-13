//
//  MainImageView.swift
//  Leeroy Crew
//
//  Created by Uladzislau Daratsiuk on 7/25/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainImageView: UIImageView {

    init(imageName: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints  = false
        self.image                                      = UIImage(named: imageName)
        self.contentMode                                = .scaleAspectFit
        self.clipsToBounds                              = true
        self.tintColor                                  = UIColor(named: "system")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
