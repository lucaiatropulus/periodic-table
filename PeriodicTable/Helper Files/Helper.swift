//
//  Helper.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 07/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import Foundation

struct Helper {
    
    static let shared = Helper()
    
    private init() {}
    
    func determineElectronShellDistribution(for element: Element) -> String {
        
        let electronShells = element.shells
        var electronShellDistribution = ""
        
        switch electronShells.count {
        case 1:
            electronShellDistribution = "K\(electronShells[0])-L0-M0-N0-O0-P0-R0"
        case 2:
            electronShellDistribution = "K\(electronShells[0])-L\(electronShells[1])-M0-N0-O0-P0-R0"
        case 3:
            electronShellDistribution = "K\(electronShells[0])-L\(electronShells[1])-M\(electronShells[2])-N0-O0-P0-R0"
        case 4:
            electronShellDistribution = "K\(electronShells[0])-L\(electronShells[1])-M\(electronShells[2])-N\(electronShells[3])-O0-P0-R0"
        case 5:
            electronShellDistribution = "K\(electronShells[0])-L\(electronShells[1])-M\(electronShells[2])-N\(electronShells[3])-O\(electronShells[4])-P0-R0"
        case 6:
            electronShellDistribution = "K\(electronShells[0])-L\(electronShells[1])-M\(electronShells[2])-N\(electronShells[3])-O\(electronShells[4])-P\(electronShells[5])-R0"
        case 7:
            electronShellDistribution = "K\(electronShells[0])-L\(electronShells[1])-M\(electronShells[2])-N\(electronShells[3])-O\(electronShells[4])-P\(electronShells[5])-R\(electronShells[6])"
        default:
            electronShellDistribution = "Shell configuration is undetermined"
        }
        
        return electronShellDistribution
    }
    
    
    func calculateGeneralMolarMass(for compound: String) -> Compound {
        
        var checkedCompound = Compound(elementsCount: [:], elements: [])
        
        if compound.contains("[") && compound.contains("]") {
            checkedCompound = calculateMolarMassWithStraightBrackets(for: compound)
        } else if compound.contains("(") && compound.contains(")") {
            checkedCompound = calculateMassForNormalBrackets(for: compound)
        } else {
            checkedCompound = calculateSimpleMolarMass(for: compound)
        }
        return checkedCompound
    }
    
    
    
    private func calculateMolarMassWithStraightBrackets(for compound: String ) -> Compound {
        
        var elements: [String] = []
        var elementsCount : [String : String] = [:]
        var element = ""
        var temporaryNumber = ""
        var firstElement: String.Index = compound.index(compound.startIndex, offsetBy: 0)
        var lastElement: String.Index = compound.index(compound.startIndex, offsetBy: 0)
        var temporaryCompound = Compound(elementsCount: [:], elements: [])
        var contor = 1
        
        for char in compound {
            
            if String(char) == "[" {
                guard let index = compound.firstIndex(of: char) else { return Compound(elementsCount: [:] , elements: [])}
                firstElement = compound.index(after: index)
            }
            
            if String(char) == "]" {
                guard let index = compound.firstIndex(of: char) else { return Compound(elementsCount: [:], elements: []) }
                lastElement = compound.index(before: index)
                let simplifiedCompound = compound[firstElement...lastElement]
                temporaryCompound = calculateGeneralMolarMass(for: String(simplifiedCompound))
            }
            
            if char.isUppercase && !temporaryCompound.elements.isEmpty {
                element = element + String(char)
            }
            
            if char.isNumber && !temporaryCompound.elements.isEmpty && element == "" {
                temporaryNumber = temporaryNumber + String(char)
                contor += 1
            }
            
        }
        
        firstElement = compound.index(firstElement, offsetBy: -1)
        lastElement = compound.index(lastElement, offsetBy: contor)
        
        for element in temporaryCompound.elements {
            
            if !elements.contains(element) {
                elements.append(element)
            }
            
            if elementsCount[element] == "" {
                elementsCount[element] = "1"
            }
            
            if temporaryCompound.elementsCount[element] == "" {
                temporaryCompound.elementsCount[element] = "1"
            }
            
            if elementsCount[element] != nil {
                if temporaryNumber == "" {
                    temporaryNumber = "1"
                }
                let firstNumber = Int(elementsCount[element]!)! * Int(temporaryNumber)!
                let secondNumber = Int(temporaryCompound.elementsCount[element]!)! * Int(temporaryNumber)!
                elementsCount[element] = String(firstNumber + secondNumber)
            } else {
                if temporaryNumber == "" {
                    temporaryNumber = "1"
                }
                elementsCount[element] = String(Int(temporaryCompound.elementsCount[element]!)! * Int(temporaryNumber)!)
            }
        }
        
        
        var mutableCompound = compound
        mutableCompound.replaceSubrange(firstElement...lastElement, with: "")
        
        
        
        temporaryCompound = calculateGeneralMolarMass(for: mutableCompound)
        
        for element in temporaryCompound.elements {
            if !elements.contains(element) {
                elements.append(element)
            }
            
            if elementsCount[element] == "" {
                elementsCount[element] = "1"
            }
            
            if temporaryCompound.elementsCount[element] == "" {
                temporaryCompound.elementsCount[element] = "1"
            }
            
            if elementsCount[element] != nil {
                elementsCount[element] = String(Int(elementsCount[element]!)! + Int(temporaryCompound.elementsCount[element]!)!)
            } else {
                elementsCount[element] = temporaryCompound.elementsCount[element]!
            }
        }
        
        
        return Compound(elementsCount: elementsCount, elements: elements)
        
    }
    
    
    private func calculateMassForNormalBrackets(for compound: String) -> Compound {
        
        
        var elements: [String] = []
        var elementsCount : [String : String] = [:]
        var element = ""
        var temporaryNumber = ""
        var firstElement: String.Index = compound.index(compound.startIndex, offsetBy: 0)
        var lastElement: String.Index = compound.index(compound.startIndex, offsetBy: 0)
        var temporaryCompound = Compound(elementsCount: [:], elements: [])
        var contor = 1
        
        for char in compound {
            
            if String(char) == "(" {
                guard let index = compound.firstIndex(of: char) else { return Compound(elementsCount: [:] , elements: [])}
                firstElement = compound.index(after: index)
            }
            
            if String(char) == ")" {
                guard let index = compound.firstIndex(of: char) else { return Compound(elementsCount: [:], elements: []) }
                lastElement = compound.index(before: index)
                let simplifiedCompound = compound[firstElement...lastElement]
                temporaryCompound = calculateGeneralMolarMass(for: String(simplifiedCompound))
            }
            
            if char.isUppercase && !temporaryCompound.elements.isEmpty {
                element = element + String(char)
            }
            
            if char.isNumber && !temporaryCompound.elements.isEmpty && element == "" {
                temporaryNumber = temporaryNumber + String(char)
                contor += 1
            }
            
        }
        
        element = ""
        
        
        firstElement = compound.index(firstElement, offsetBy: -1)
        lastElement = compound.index(lastElement, offsetBy: contor)
        
        for element in temporaryCompound.elements {
            
            if !elements.contains(element) {
                elements.append(element)
            }
            
            if elementsCount[element] == "" {
                elementsCount[element] = "1"
            }
            
            if temporaryCompound.elementsCount[element] == "" {
                temporaryCompound.elementsCount[element] = "1"
            }
            
            if elementsCount[element] != nil {
                if temporaryNumber == "" {
                    temporaryNumber = "1"
                }
                let firstNumber = Int(elementsCount[element]!)! * Int(temporaryNumber)!
                let secondNumber = Int(temporaryCompound.elementsCount[element]!)! * Int(temporaryNumber)!
                elementsCount[element] = String(firstNumber + secondNumber)
            } else {
                if temporaryNumber == "" {
                    temporaryNumber = "1"
                }
                elementsCount[element] = String(Int(temporaryCompound.elementsCount[element]!)! * Int(temporaryNumber)!)
            }
        }
        
        
        var mutableCompound = compound
        mutableCompound.replaceSubrange(firstElement...lastElement, with: "")
        
        
        
        temporaryCompound = calculateGeneralMolarMass(for: mutableCompound)
        
        for element in temporaryCompound.elements {
            if !elements.contains(element) {
                elements.append(element)
            }
            
            if elementsCount[element] == "" {
                elementsCount[element] = "1"
            }
            
            if temporaryCompound.elementsCount[element] == "" {
                temporaryCompound.elementsCount[element] = "1"
            }
            
            if elementsCount[element] != nil {
                elementsCount[element] = String(Int(elementsCount[element]!)! + Int(temporaryCompound.elementsCount[element]!)!)
            } else {
                elementsCount[element] = temporaryCompound.elementsCount[element]!
            }
        }
        
        return Compound(elementsCount: elementsCount, elements: elements)
    }
    
    
    private func calculateSimpleMolarMass(for compound: String) -> Compound {
        
        var elements: [String] = []
        var elementsCount : [String : String] = [:]
        var element = ""
        
        for char in compound {
            
            if char.isUppercase && !element.isEmpty {
                elements.append(element)
                elementsCount[element] = ""
                element = ""
                element = element + String(char)
            } else if char.isUppercase {
                element = element + String(char)
            }
            
            if char.isLowercase {
                element = element + String(char)
            }
            
            if char.isNumber {
                if !element.isEmpty {
                    elements.append(element)
                    element = ""
                }
                if elementsCount[elements[elements.count-1]] != nil && elements[elements.count-1] == element {
                    elementsCount[elements[elements.count-1]] = elementsCount[elements[elements.count-1]]! + String(char)
                } else {
                    elementsCount[elements[elements.count-1]] = String(char)
                }
            }
            
            
            
        }
        
        if !element.isEmpty && elementsCount[element] == nil {
            
            elementsCount[element] = "1"
            elements.append(element)
            
        } else if !element.isEmpty && elementsCount[element] != nil && elements.contains(element) {
            elementsCount[element] = String(Int(elementsCount[element]!)! + 1)
        }
        let checkedCompound = Compound(elementsCount: elementsCount, elements: elements)
        return checkedCompound
    }
    
    
    func updateSum(with atomicMassValues: [String : Float], in compound: Compound) -> Float {
        
        var sum: Float = 0
        var mutableCompound = compound
        
        for element in mutableCompound.elements {
            
            guard let atomicMass = atomicMassValues[element] else {
                sum = -1
                return sum
            }
            
            if mutableCompound.elementsCount[element] == "" {
                mutableCompound.elementsCount[element] = "1"
            }
            
            switch element {
                
            case "H":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "He":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Li":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Be":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "B":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "C":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "N":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "O":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "F":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ne":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Na":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Mg":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Al":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Si":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "P":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "S":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Cl":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ar":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "K":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ca":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Sc":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ti":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "V":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Cr":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Mn":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Fe":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Co":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ni":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Cu":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Zn":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ga":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ge":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "As":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Se":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Br":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Kr":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Rb":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Sr":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Y":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Zr":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Nb":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Mo":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Tc":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ru":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Rh":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Pd":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ag":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Cd":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "In":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Sn":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Sb":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Te":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "I":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Xe":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Cs":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ba":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "La":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ce":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Pr":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Nd":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Pm":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Sm":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Eu":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Gd":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Tb":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Dy":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ho":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Er":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Tm":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Yb":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Lu":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Hf":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ta":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "W":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Re":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Os":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ir":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Pt":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Au":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Hg":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Tl":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Pb":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Bi":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Po":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "At":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Rn":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Fr":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ra":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ac":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Th":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Pa":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "U":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Np":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Pu":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Am":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Cm":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Bk":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Cf":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Es":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Fm":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Md":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "No":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Lr":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Rf":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Db":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Sg":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Bh":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Hs":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Mt":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ds":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Rg":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Cn":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Nh":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Fl":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Mc":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Lv":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Ts":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Og":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            case "Uue":
                sum = sum + Float(compound.elementsCount[element]!)! * atomicMass
            default:
                sum = sum + 0
            }
        }
        
        return sum
    }

}


