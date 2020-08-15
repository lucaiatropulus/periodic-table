//
//  MollarMassDetailCell.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 09/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class MollarMassDetailCell: UITableViewCell {

    static let reuseID = "MollarMassDetailCell"
    
    private let symbolLabel = PTLabel(textAlignment: .left, textColor: .label, fontSize: 18, fontWeight: .regular)
    private let valueLabel  = PTLabel(textAlignment: .right, textColor: .label, fontSize: 18, fontWeight: .regular)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(element: Element, atomicValues: [Element : Float] ) {
        guard let value = atomicValues[element] else { return }
        symbolLabel.text    = element.name
        valueLabel.text     = String(format: "%.2f" , value)
        
    }
    
    private func configure() {
        backgroundColor = .systemGray6
        selectionStyle = .none
        configureSymbolLabel()
        configureValueLabel()
    }
    
    private func configureSymbolLabel() {
        contentView.addSubview(symbolLabel)
        
        NSLayoutConstraint.activate([
        
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            symbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbolLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10),
        
        ])
    }
    
    private func configureValueLabel() {
        contentView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
        
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10)
            
        ])
    }
    
    

}
