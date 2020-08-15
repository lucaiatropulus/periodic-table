//
//  ElementCell.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 03/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {

    static let reuseID = "TableViewElementCell"
    
    let containerView       = UIView()
    let elementView         = UIView()
    let symbolLabel         = PTTitleLabel(textAlignment: .center)
    let elementNameLabel    = PTSystemLabel(textAlignment: .left, textStyle: .headline, textColor: .label)
    let molarMassLabel      = PTSystemLabel(textAlignment: .left, textStyle: .subheadline, textColor: .secondaryLabel)
    
    private let padding: CGFloat = 10
    
    private enum Categories {
        static let diatomicNonmetal = "diatomic nonmetal"
        static let nobleGas = "noble gas"
        static let alkaliMetal = "alkali metal"
        static let alkalineEarthMetal = "alkaline earth metal"
        static let metalloid = "metalloid"
        static let polyatomicNonmetal = "polyatomic nonmetal"
        static let postTransitionMetal = "post-transition metal"
        static let transitionMetal = "transition metal"
        static let lanthanide = "lanthanide"
        static let actinide = "actinide"
    }
    
    func set(element: Element) {
        symbolLabel.text        = element.symbol
        elementNameLabel.text   = element.name
        molarMassLabel.text     = String(format: "%.4f", element.atomicMass) + " g/mol"
        
        switch element.category {
        case Categories.diatomicNonmetal:
            elementView.backgroundColor = .systemRed
        case Categories.nobleGas:
            elementView.backgroundColor = .systemBlue
        case Categories.alkaliMetal:
            elementView.backgroundColor = .systemPink
        case Categories.alkalineEarthMetal:
            elementView.backgroundColor = .systemTeal
        case Categories.metalloid:
            elementView.backgroundColor = .systemGreen
        case Categories.polyatomicNonmetal:
            elementView.backgroundColor = .systemIndigo
        case Categories.postTransitionMetal:
            elementView.backgroundColor = .systemOrange
        case Categories.transitionMetal:
            elementView.backgroundColor = .systemPurple
        case Categories.lanthanide:
            elementView.backgroundColor = .systemYellow
        case Categories.actinide:
            elementView.backgroundColor = .magenta
        default:
            elementView.backgroundColor = .systemBackground
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configureContainerView()
        configureElementView()
        configureSymbolLabel()
        configureElementNameLabel()
        configureMolarMassLabel()
        
        backgroundColor = .systemGray6
        accessoryType   = .disclosureIndicator
        selectionStyle  = .none
    }
    
    private func configureContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding/2),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2*padding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2*padding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: padding/2)
            
        ])
    }
    
    private func configureElementView() {
        containerView.addSubview(elementView)
        elementView.layer.cornerRadius = 25
        elementView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            elementView.topAnchor.constraint(equalTo: containerView.topAnchor),
            elementView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            elementView.heightAnchor.constraint(equalToConstant: 50),
            elementView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSymbolLabel() {
        elementView.addSubview(symbolLabel)
        symbolLabel.textColor                   = .white
        symbolLabel.adjustsFontSizeToFitWidth   = true
        symbolLabel.minimumScaleFactor          = 0.75
        
        NSLayoutConstraint.activate([
        
            symbolLabel.centerXAnchor.constraint(equalTo: elementView.centerXAnchor),
            symbolLabel.centerYAnchor.constraint(equalTo: elementView.centerYAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: elementView.leadingAnchor, constant: padding),
            symbolLabel.trailingAnchor.constraint(equalTo: elementView.trailingAnchor, constant: -padding)
    
        ])
    }
    
    private func configureElementNameLabel() {
        containerView.addSubview(elementNameLabel)
        
        NSLayoutConstraint.activate([
        
            elementNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            elementNameLabel.leadingAnchor.constraint(equalTo: elementView.trailingAnchor, constant: 2*padding),
            elementNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -2*padding),
        
        ])
    }
    
    private func configureMolarMassLabel() {
        containerView.addSubview(molarMassLabel)
        
        NSLayoutConstraint.activate([
        
            molarMassLabel.topAnchor.constraint(equalTo: elementNameLabel.bottomAnchor, constant: padding/2),
            molarMassLabel.leadingAnchor.constraint(equalTo: elementNameLabel.leadingAnchor),
            molarMassLabel.trailingAnchor.constraint(equalTo: elementNameLabel.trailingAnchor)
        
        ])
    }
    
    

}
