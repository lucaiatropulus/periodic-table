//
//  PTSubtitleLabel.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 03/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class PTSystemLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, textStyle: UIFont.TextStyle, textColor: UIColor) {
        super.init(frame: .zero)
        self.textColor      = textColor
        self.textAlignment  = textAlignment
        self.font           = UIFont.preferredFont(forTextStyle: textStyle)
        configure()
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.9
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
    }

}
