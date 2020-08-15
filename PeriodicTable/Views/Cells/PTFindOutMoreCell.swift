//
//  PTFindOutMoreCell.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 05/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit

class PTFindOutMoreCell: UITableViewCell {
    
    static let reuseID = "FindOutMoreCell"
    
    let findOutMoreLabel  = PTNormalLabel(textAlignment: .center, textColor: .label, fontSize: 20, fontWeight: .medium)
    let findOutMoreButton = PTButton(title: "Wikipedia", and: .systemGreen)

   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       configureUI()
       backgroundColor = .systemGray6
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    
    private func configureUI() {
        contentView.backgroundColor = .systemGray6
        configureFindOutMoreButton()
        configureFindOutMoreLabel()
    }
    
    private func configureFindOutMoreLabel() {
        contentView.addSubview(findOutMoreLabel)
        findOutMoreLabel.text = "Find out more on"
        NSLayoutConstraint.activate([
        
            findOutMoreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            findOutMoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            findOutMoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            findOutMoreLabel.bottomAnchor.constraint(equalTo: findOutMoreButton.topAnchor, constant: -10)
        
        ])
    }
    

    
    private func configureFindOutMoreButton() {
        contentView.addSubview(findOutMoreButton)
        
        NSLayoutConstraint.activate([
            
            findOutMoreButton.widthAnchor.constraint(equalToConstant: 200),
            findOutMoreButton.heightAnchor.constraint(equalToConstant: 50),
            findOutMoreButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            findOutMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        
        ])
    }
    
    


}
