//
//  MenuResponse.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import Foundation

public class Menu:CustomCodable {
  var categories:[Category] = []

    //    required public init(from decoder: Decoder) throws {
//          let container = try decoder.container(keyedBy: CodingKeys.self)
//         if let categories = try container.decodeIfPresent([Category].self, forKey: .categories) {
//              self.categories = categories
//          }
//
//    }
    
}

public class MenuWrapper:CustomCodable {
    var data:Menu = Menu()
}
