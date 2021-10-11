//
//  Product.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import Foundation
public class Product:CustomCodable, Hashable,Identifiable {

    
   public var id = 0
    var name = "Unknown"
    var shortDescription:String? = ""
    var price = 0.0
    var sku = ""
    var categoryId = 0
    var chefId = 0
    var chefFirstName = ""
    var chefLastName = ""
    var isCelebrity = false
    var feature : Feature?
    var nutritionalFacts: NutritionalFacts?
    var filterBy = [""]
    var stars = 0.0
    var reviews = 0
    var userRating: Double?
    var warning: String?
    var warnings: Warning?
    var weight: Double?
    var ingredientsData:[Ingredient]?
    
    enum  CodingKeys: String, CodingKey {
     case name,shortDescription,price,sku,categoryId,chefId,feature,nutritionalFacts,filterBy,stars,reviews,userRating,warning,warnings,weight,ingredientsData
     case id = "entityId"
     case chefFirstName = "chefFirstname"
     case chefLastName = "chefLastname"
     case isCelebrity = "isCelebrityChef"
        
    }
    
   public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}


public class Ingredient : CustomCodable {
    var id:Int? = 0
    var name = ""
    var value:String? = ""
    enum  CodingKeys: String, CodingKey {
        case id = "entityId"
        case name,value
        
    }
    
}

public class Warning:CustomCodable {
    var message = ""
    var restrictionsApplied:[Restriction] = []
}

public class Restriction:CustomCodable {
    var name = ""
}

public class NutritionalFacts:CustomCodable {
    var calories:String? = ""
    var fat:String? = ""
    var servingsize:String? = ""
    var carbs:String? = ""
    var fiber:String? = ""
    var protein:String? = ""
    var saturatedFat:String? = ""
    var sodium:String? = ""
    var sugar:String? = ""
}


public class Feature: Codable {
    var name = ""
    var description = ""
    var icon = ""
    var color = ""
    var background = ""
    
    
}
