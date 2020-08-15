//
//  Constants.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 07/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import UIKit


struct ElementProperties {
    
    static let name             = "Name:"
    static let symbol           = "Symbol:"
    static let category         = "Category:"
    static let appearance       = "Appearance:"
    static let color            = "Color:"
    static let phase            = "Phase:"
    static let discoveredBy     = "Discovered by:"
    static let namedBy          = "Named by:"
    static let electronShell    = "Electron Shell:"
    
    static let atomicNumber     = "Atomic Number:"
    static let atomicMass       = "Atomic Mass:"
    static let density          = "Density:"
    static let meltingPoint     = "Melting Point:"
    static let boilingPoint     = "Boiling Point:"
    static let period           = "Period:"
    
    static let electronConfiguration            = "Electron Configuration:"
    static let electronConfigurationSemantic    = "Electron Configuration Semantic:"
    
    static let electronegativity    = "Electronegativity:"
    static let electronAffinity     = "Electron Affinity:"
    
}

struct CategoryTitles {
    
    static let general          = "General"
    static let properties       = "Properties"
    static let atomicProperties = "Atomic Properties"
    static let reactivity       = "Reactivity"
    
}

struct CategoryImages {
    
    static let general          = UIImage(named: "general")!
    static let properties       = UIImage(named: "properties")!
    static let atomicProperties = UIImage(named: "atomicproperties")!
    static let reactvity        = UIImage(named: "reactivity")!
    static let electromagnetism = UIImage(named: "electromagnetism")!
    
}
