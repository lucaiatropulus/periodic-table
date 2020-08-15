//
//  PTMolarMassView.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 09/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class PTMolarMassView: UIView {
    
    private let mollarMassLabel         = PTLabel(textAlignment: .left, textColor: .label, fontSize: 18, fontWeight: .regular)
    private let mollarMassValueLabel    = PTLabel(textAlignment: .right, textColor: .label, fontSize: 18, fontWeight: .regular)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(value: Float) {
        mollarMassValueLabel.text = String(format: "%.2f", value)
    }
    
    private func configure() {
        backgroundColor = .systemGray6
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        configureMollarMassLabel()
        configureMollarMassValueLabel()
    }
    
    private func configureMollarMassLabel() {
        addSubview(mollarMassLabel)
        mollarMassLabel.text = "Total"
        
        NSLayoutConstraint.activate([
        
            mollarMassLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mollarMassLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            mollarMassLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -10),
        
        ])
    }
    
    
    private func configureMollarMassValueLabel() {
        addSubview(mollarMassValueLabel)
        
        NSLayoutConstraint.activate([
        
            mollarMassValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mollarMassValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            mollarMassValueLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -10)
            
        ])
    }
    
}
