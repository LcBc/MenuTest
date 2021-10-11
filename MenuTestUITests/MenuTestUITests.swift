//
//  MenuTestUITests.swift
//  MenuTestUITests
//
//  Created by Luis Barrios on 8/10/21.
//

import XCTest

class MenuTestUITests: XCTestCase {

    var app: XCUIApplication!
     override func setUpWithError() throws {
         // Put setup code here. This method is called before the invocation of each test method in the class.

         // In UI tests it is usually best to stop immediately when a failure occurs.
       try super.setUpWithError()
       continueAfterFailure = false
       app = XCUIApplication()
       app.launch()

         // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
     }
    
    
    func testAddMeal(){
        XCUIApplication().tables.cells["Slow-Roasted Cod"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        
    }
    
//    func testRemoveMeal(){
//
//    }
//
//    func testAddLimitMeals(){}
    

}
