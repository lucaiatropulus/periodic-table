//
//  DataLoadingManager.swift
//  PeriodicTable
//
//  Created by Luca Nicolae Iatropulus on 03/08/2020.
//  Copyright © 2020 Luca Nicolae Iatropulus. All rights reserved.
//

import Foundation

class DataLoadingManager {
    
    static let shared = DataLoadingManager()
    
    private init() {}
    
    func loadData(completed: @escaping (Result<[Element], PTError>)  -> Void) {
        if let fileLocation =  Bundle.main.url(forResource: "periodictable", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataFromJson = try jsonDecoder.decode(Elements.self, from: data)
                completed(.success(dataFromJson.elements))
                
                
            } catch {
                completed(.failure(.unableToGetData))
            }
            
        } else {
            completed(.failure(.unableToGetData))
        }
    }
    
}
