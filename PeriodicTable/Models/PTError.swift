//
//  PTError.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 03/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import Foundation

enum PTError: String, Error {
    
    case unableToGetData = "We were unable to load the elements. Please try opening the application again."
    case notFound = "The answer is not found. Try to query in a different way"
}
