//
//  Category.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import Foundation


public class Category: CustomCodable,Identifiable {
    
    public var id: Int = -1
    var title:String = "Unknown"
    var label: String = ""
    var subtitle : String = ""
   public var meals:[Product]?
    
//    required public init(from decoder: Decoder) throws {
//          let container = try decoder.container(keyedBy: CodingKeys.self)
//         if let id = try container.decodeIfPresent(Int.self, forKey: .id) {
//              self.id = id
//          }
//        if let label = try container.decodeIfPresent(String.self, forKey: .label) {
//             self.label = label
//         }
//        if let title = try container.decodeIfPresent(String.self, forKey: .title) {
//             self.title = title
//         }
//        if let subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle) {
//             self.subtitle = subtitle
//         }
//      
//    }
    
}

