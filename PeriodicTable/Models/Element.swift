//
//  Element.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 03/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import Foundation

struct Elements: Codable, Hashable {
    var elements: [Element]
}


struct Element: Codable, Hashable {
    
    var name: String
    var appearance: String?
    var atomicMass: Float
    var boil: Float?
    var category: String
    var color: String?
    var density: Double?
    var discoveredBy: String?
    var melt: Float?
    var molarMelt: Float?
    var namedBy: String?
    var number: Int
    var period: Int
    var phase: String
    var source: String
    var spectralImg: String?
    var summary: String
    var symbol: String
    var xpos: Int
    var ypos: Int
    var shells: [Int]
    var electronConfiguration: String
    var electronConfigurationSemantic: String
    var electronAffinity: Float?
    var electronegativityPauling: Float?
    var ionizationEnergies: [Float]
}
