//
//  CategoryViewModelTest.swift
//  MenuTestTests
//
//  Created by Luis Barrios on 9/10/21.
//

import XCTest
@testable import MenuTest
import SwiftUI
class CategoryViewModelTest: XCTestCase {

    var menu: MenuTest.Menu!
    var sut: CategorySelectionViewModel!
    override func setUpWithError() throws {
        try super.setUpWithError()
       let menuViewModel = MenuSelectionViewModel(with: defaultMenuDataManager, and: defaulMaxProducts)
        menu = menuViewModel.fetchMenu()
        sut = CategorySelectionViewModel(menu: menuViewModel.menu!, delegate: menuViewModel)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        menu = nil
    }

    
 
    func testSelectOneMeal(){
        sut.toggleSelection(meal: menu.categories.first!.meals!.first!)
        XCTAssertEqual(sut.selection.count, 1, "unexpected number of meals")
    }
    
    
    func testToggleOneMeal(){
        sut.toggleSelection(meal: menu.categories.first!.meals!.first!)
        sut.toggleSelection(meal: menu.categories.first!.meals!.first!)
        XCTAssertEqual(sut.selection.count, 0, "unexpected number of meals")
    }
    


}
