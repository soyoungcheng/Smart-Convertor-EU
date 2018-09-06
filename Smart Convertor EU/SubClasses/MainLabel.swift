//
//  CardLabel.swift
//  Leeroy Crew
//
//  Created by Uladzislau Daratsiuk on 7/12/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainLabel: UILabel {
    
    let mainTextSize: CGFloat = 15

    init(text: String, textAligment: NSTextAlignment, numberOfLines: Int) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAligment
        self.font = UIFont(name: .liteFont, size: mainTextSize)
        self.textColor = .mainTextColor
        self.text = text
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
        self.numberOfLines = numberOfLines
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
