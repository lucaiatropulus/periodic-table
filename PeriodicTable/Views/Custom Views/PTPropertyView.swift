//
//  PTElementPropertyView.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 07/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class PTPropertyView: UIView {
    
    private var stackView: UIStackView!
    private let containerView   = UIView()
    private let separatorView   = UIView()
    private let nameLabel       = PTLabel(textAlignment: .left, textColor: .label, fontSize: 18, fontWeight: .regular)
    private let propertyLabel   = PTLabel(textAlignment: .left, textColor: .label, fontSize: 18, fontWeight: .regular)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(propertyName: String) {
        super.init(frame: .zero)
        configure()
        nameLabel.text = propertyName
        
        switch propertyName {
        case ElementProperties.electronShell, ElementProperties.period, ElementProperties.electronConfigurationSemantic:
            break
        default:
            configureSeparatorView()
        }
    }
    
    
    func set(propertyValue: String) {
        
        switch propertyValue {
        case "Value not provided" :
            propertyLabel.textColor = .secondaryLabel
            nameLabel.textColor = .secondaryLabel
        default:
            break
        }
        
        propertyLabel.text  = propertyValue
    }
    
    func set(atomicMass: Float) {
        nameLabel.text      = "Total molar mass for the compound is:"
        propertyLabel.text  = String(format: "%.2f", atomicMass)
    }
    
    func constrainToMargins(in stackView: UIStackView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
        trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
            
        ])
    
    }
    
    private func configure() {
        backgroundColor = .systemGray6
        translatesAutoresizingMaskIntoConstraints = false
        configureStackView()
        configureElementPropertyNameLabel()
        configureElementPropertyValueLabel()
    }
    
    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: [nameLabel, propertyLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        stackView.backgroundColor = .red
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        
        ])
    }
    
    private func configureElementPropertyNameLabel() {
        NSLayoutConstraint.activate([
        
            nameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        
        ])
    }
    
    private func configureElementPropertyValueLabel() {
        NSLayoutConstraint.activate([
            
            propertyLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            propertyLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        
        ])
    }
    
    private func configureSeparatorView() {
        addSubview(separatorView)
        separatorView.backgroundColor = .systemGray3
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            separatorView.heightAnchor.constraint(equalToConstant: 0.75),
            separatorView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
    

}
