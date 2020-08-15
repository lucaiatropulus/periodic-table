//
//  PTPropertyCategoryView.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 07/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class PTCategoryView: UIView {
    
    private let categoryLabel = PTTitleLabel(textAlignment: .left)
    private let imageView = UIImageView()
    
    private let topSeparatorView = UIView()
    private let bottomSeparatorView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(categoryTitle: String) {
        super.init(frame: .zero)
        configure()
        categoryLabel.text = categoryTitle
        
        switch categoryTitle {
        case CategoryTitles.general:
            imageView.image = CategoryImages.general
        case CategoryTitles.properties:
            imageView.image = CategoryImages.properties
        case CategoryTitles.atomicProperties:
            imageView.image = CategoryImages.atomicProperties
        case CategoryTitles.reactivity:
            imageView.image = CategoryImages.reactvity
        default:
            imageView.image = UIImage()
        }
    }
    
    private func configure() {
        backgroundColor = .systemGray5
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        configureImageView()
        configureCategoryLabel()
        configureSeparatorViews()
    }
    
    func constrainToMargins(in stackView: UIStackView) {
        
        NSLayoutConstraint.activate([
            
        leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
        trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
            
        ])
    
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 22),
            imageView.widthAnchor.constraint(equalToConstant: 22)
        ])
    }
       
    private func configureCategoryLabel() {
        addSubview(categoryLabel)
               
               NSLayoutConstraint.activate([
               
                   categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                   categoryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                   categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                   categoryLabel.heightAnchor.constraint(equalToConstant: 24)
           
               ])
           }
    
    private func configureSeparatorViews() {
        addSubview(topSeparatorView)
        addSubview(bottomSeparatorView)
        topSeparatorView.backgroundColor = .systemGray3
        bottomSeparatorView.backgroundColor = .systemGray3
        topSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            topSeparatorView.heightAnchor.constraint(equalToConstant: 0.75),
            topSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparatorView.topAnchor.constraint(equalTo: topAnchor),
            
            bottomSeparatorView.heightAnchor.constraint(equalToConstant: 0.75),
            bottomSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
}
