//
//  MenuTestTests.swift
//  MenuTestTests
//
//  Created by Luis Barrios on 8/10/21.
//

import XCTest
@testable import MenuTest

class MenuDataManagerTests: XCTestCase {
    
    var sut: MenuDataManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MenuFileManager(for: "menu", of: "json")
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func testMenuFetch(){
        
        let result =  sut.fetchMenu()
        
        XCTAssertNotNil(result, "did not parse the json")
        
        
    }
    
    func testGetDataFromExistingJSONFile(){
        let result = getData(from: "menu", with: "json")
        XCTAssertNotNil(result, "did not fetch the file")
    }
    
    
    func testGetDataFromInvalidJSONFile(){
        let result = getData(from: "xxx", with: "json")
        XCTAssertNil(result, "file fetched")
    }
    
    func testAllMealsAreUnique(){
        let menu = sut.fetchMenu()
        var productSet = Set<Product>()
        var productArray:[Product] = []
        if let menu = menu {
            menu.categories.forEach{ cat in
                cat.meals?.forEach{ meal in
                    productSet.insert(meal)
                    productArray.append(meal)
                }
                
            }
        }
        XCTAssertEqual(productArray.count, productSet.count, "Expected \(productSet.count) meals found \(productArray.count)")
        
    }
    
}
