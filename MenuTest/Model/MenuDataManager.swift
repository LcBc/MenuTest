//
//  MenuManager.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import Foundation


public protocol MenuDataManager{
     func fetchMenu() -> Menu?
}



public class MenuFileManager:MenuDataManager{
    
    private var fileName:String
    private var fileExtension:String
    
    public init(for file:String, of type: String){
        self.fileName = file
        self.fileExtension = type
    }
    
    
    public func fetchMenu() -> Menu?{
        if let data = getData(from: self.fileName, with: self.fileExtension){
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decoded = try decoder.decode(MenuWrapper.self, from: data)
                return decoded.data
            } catch {
                
                return nil
               
            }
            
        }
            return nil
    }
    
    
}
