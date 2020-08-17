//
//  PTMolarMassView.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 09/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class PTMolarMassView: UIView {
    
    private let molarMassLabel         = PTLabel(textAlignment: .left, textColor: .label, fontSize: 18, fontWeight: .regular)
    private let molarMassValueLabel    = PTLabel(textAlignment: .right, textColor: .label, fontSize: 18, fontWeight: .regular)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(value: Float) {
        molarMassValueLabel.text = String(format: "%.2f", value)
    }
    
    private func configure() {
        backgroundColor = .systemGray6
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        configureMolarMassLabel()
        configureMolarMassValueLabel()
    }
    
    private func configureMolarMassLabel() {
        addSubview(molarMassLabel)
        molarMassLabel.text = "Total"
        
        NSLayoutConstraint.activate([
        
            molarMassLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            molarMassLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            molarMassLabel.widthAnchor.constraint(equalToConstant: 140)
        
        ])
    }
    
    
    private func configureMolarMassValueLabel() {
        addSubview(molarMassValueLabel)
        NSLayoutConstraint.activate([
        
            molarMassValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            molarMassValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            molarMassValueLabel.widthAnchor.constraint(equalToConstant: 140)
            
        ])
    }
    
}
