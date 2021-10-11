//
//  Utils.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import Foundation

func getData(from file:String,with type:String) -> Data? {
    
    
    if let path = Bundle.main.path(forResource: file, ofType: type) {
        do {
              let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
               return data
          } catch {
               return nil
          }
    }
    return nil
    
}

var defaultMenuDataManager:MenuDataManager{
    return MenuFileManager(for: "menu", of: "json")
}

let defaulMaxProducts = 6
