//
//  CardScrollView.swift
//  Leeroy Crew
//
//  Created by Uladzislau Daratsiuk on 7/16/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "background")
        self.contentSize.height = 800
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
