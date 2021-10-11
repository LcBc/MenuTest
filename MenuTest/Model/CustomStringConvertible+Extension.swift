//
//  File.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import Foundation

public extension CustomStringConvertible{
    
   var description :String{
        
        var description = "******\(type(of: self))*****\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children{
            if let propertyName = child.label {
                description += "\(propertyName) : \(child.value) \n"
            }
        }
        return description
    }
    
    
}

public protocol CustomCodable: Codable, CustomStringConvertible {
    
}
