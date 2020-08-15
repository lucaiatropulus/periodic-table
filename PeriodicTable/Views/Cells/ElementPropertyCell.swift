//
//  ElementPropertyCell.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 04/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class ElementPropertyCell: UITableViewCell {

    static let reuseID = "TableViewElementPropertyCell"
    
    let propertyLabel = PTNormalLabel(textAlignment: .left, textColor: .label, fontSize: 20, fontWeight: .medium)
    let padding: CGFloat = 20
    
    func set(elementProperty: String) {
        if elementProperty.contains("No Data Provided") {
            propertyLabel.textColor = .secondaryLabel
        }
        propertyLabel.text = elementProperty
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurePropertyLabel()
        backgroundColor = .systemGray6
        selectionStyle  = .none
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePropertyLabel() {
        contentView.addSubview(propertyLabel)
        
        NSLayoutConstraint.activate([
        
            propertyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            propertyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            propertyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            propertyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
            
        ])
    }

}
