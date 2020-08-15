//
//  WikipediaButtonView.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 08/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

protocol WikipediaButtonViewDelegate: class {
    func presentWikipediaPage()
}

class WikipediaButtonView: UIView {
    
    private let wikipediaButton = PTButton(title: "Wikipedia", backgroundColor: .secondaryColor)
    weak var delegate: WikipediaButtonViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func presentPage() {
        delegate?.presentWikipediaPage()
    }
    
    private func configure() {
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        configureWikipediaButton()
    }
    
    private func configureWikipediaButton() {
        addSubview(wikipediaButton)
        wikipediaButton.addTarget(self, action: #selector(presentPage), for: .touchUpInside)
        NSLayoutConstraint.activate([
        
            wikipediaButton.widthAnchor.constraint(equalToConstant: 200),
            wikipediaButton.heightAnchor.constraint(equalToConstant: 50),
            wikipediaButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            wikipediaButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        ])
    }
    
    
    
}
