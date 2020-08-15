//
//  PTBodyLabel.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 03/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class PTBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        font                                        = UIFont.preferredFont(forTextStyle: .body)
        textColor                                   = .label
        numberOfLines                               = 0
        lineBreakMode                               = .byWordWrapping
        minimumScaleFactor                          = 0.75
        adjustsFontSizeToFitWidth                   = true
        translatesAutoresizingMaskIntoConstraints   = false

    }


}
