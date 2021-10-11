//
//  MenuViewModelTests.swift
//  MenuTestTests
//
//  Created by Luis Barrios on 8/10/21.
//

import XCTest
@testable import MenuTest
import SwiftUI

class MenuViewModelTests: XCTestCase {
    
    var sut: MenuSelectionViewModel!
    var limit = 6
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MenuSelectionViewModel(with: MenuFileManager(for: "menu", of: "json"),and: limit)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func testMenuViewModelMenuInitialState(){
        let result = sut.menu
        XCTAssertNil(result, "initial menu is not null")
    }
    
    func testMenuViewModelSelectionInitialState(){
        let result = sut.selection.count
        let expected = 0
        XCTAssertEqual(result, expected, "There are previously selected meals ")
    }
    
    func testMenuViewModelIsReadyInitialState(){
        let expected = false
        let result = sut.isReady
        XCTAssertEqual(result, expected, "There selection state is wrong ")
    }
    
    func testMenuViewModelSelectionDescriptionInitialState(){
      let expected = "Add 6 More Meals to Continue"
      let result = sut.selectionDescription
     XCTAssertEqual(result, expected, "There description is wrong ")
    }
    
    func testMenuViewModelFetchMenu(){
        let result = sut.fetchMenu()
        XCTAssertNotNil(result, "Menu data was not set")
    }
    
    func testAddOneProductToSelection(){
        sut.fetchMenu()
        let firstCategory = sut.menu?.categories.first
        if  let firstProduct = firstCategory?.meals?.first {
            sut.add(product: firstProduct)
        }
        
        XCTAssertEqual(sut.selection.count, 1, "The number of products in the selection is different to the expected number of products")
    }
    
    //Modify to mark this test as failable
    func testAddMultipleProducts(){
        sut.fetchMenu()
        let expected = sut.menu?.categories.count
        sut.menu?.categories.forEach{ cat in
            if let meal = cat.meals?.first {
                sut.add(product:meal )
            }
        }
        XCTAssertEqual(sut.selection.count, expected, "Expected \(expected ?? 0) meals found \(sut.selection.count)")
    }
    
    
    
    //Revisar como agregar relacion entre pruebas
    func testRemoveProductFromSelection(){
        sut.fetchMenu()
        let expected = 0
        if let firstCategory = sut.menu?.categories.first, let firstProduct = firstCategory.meals?.first {
            sut.add(product: firstProduct)
            sut.remove(product: firstProduct)
        }
        XCTAssertEqual(sut.selection.count, expected, "The number of products in the selection is different to the expected number of products")
    }
    
    func testPartialRemoval(){
        sut.fetchMenu()
        let expected = (sut.menu?.categories.count ?? 0) - 1
        sut.menu?.categories.forEach{ cat in
            if let meal = cat.meals?.first {
                sut.add(product:meal )
            }
        }
        if let firstCategory = sut.menu?.categories.first, let firstProduct = firstCategory.meals?.first {
            sut.remove(product: firstProduct)
        }
        XCTAssertEqual(sut.selection.count , expected, "Expected \(expected) meals found \(sut.selection.count)")
    }
    
    func testRemoveAll(){
        sut.fetchMenu()
        let expected = 0
        sut.menu?.categories.forEach{ cat in
            if let meal = cat.meals?.first {
                sut.add(product:meal)
            }
        }
        sut.clearSelection()
        XCTAssertEqual(sut.selection.count , expected, "Expected \(expected) meals found \(sut.selection.count)")
    }
    
    
    func testExtraPriceWhenMealsOverLimitAndNoExtra(){
        sut.fetchMenu()
        var expected = 0.0
        if let meals = sut.menu?.categories.first {
            for index in 0...6 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                    if index >= 6  {
                        expected += meal.price
                    }
                }
            }
        }
        XCTAssertEqual(sut.extraPrice,expected, "The extra ammount is incorrect")
    }
    
    func testSelectionDescriptionWhenMealsOverLimitAndNoExtra(){
        sut.fetchMenu()
        var extraPrince = 0.0
        if let meals = sut.menu?.categories.first {
            for index in 0...6 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                    if index >= 6  {
                        extraPrince += meal.price
                    }
                }
            }
        }
        let expected = "Continue(+ \(extraPrince))"
        XCTAssertEqual(sut.selectionDescription,expected, "The description value is incorrect")
    }
    
    func testExtraPriceWhenMealsOverLimitAndOneExtras(){
        sut.fetchMenu()
        var expected = 0.0
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                    if index >= 6 {
                        expected += meal.price
                    }
                }
            }
        }
        
        if let drinks = sut.menu?.categories[safe: 1]{
            if let drink = drinks.meals?.first {
                sut.add(product: drink)
                expected += drink.price
            }
        }
        XCTAssertEqual(expected, sut.extraPrice, "The extra ammount is incorrect")
        
    }

    func testSelectionDescriptionWhenMealsOverLimitAndOneExtra(){
        sut.fetchMenu()
        var extraPrince = 0.0
        if let meals = sut.menu?.categories.first {
            for index in 0...6 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                    if index >= 6  {
                        extraPrince += meal.price
                    }
                }
            }
        }
        if let drinks = sut.menu?.categories[safe: 1]{
            if let drink = drinks.meals?.first {
                sut.add(product: drink)
                extraPrince += drink.price
            }
        }
        let expected = "Continue(+ \(extraPrince))"
        XCTAssertEqual(sut.selectionDescription,expected, "The description value is incorrect")
    }
    
    

    
    
    func testExtraPriceWhenMealsAreInLimitAndNoExtra(){
        sut.fetchMenu()
        let expected = 0.0
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6 - 1 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
            XCTAssertEqual(sut.extraPrice, expected , "The extra ammount is incorrect")
            
        }
    }
    
    func testSelectionDescriptionMealsAreInLimitAndNoExtra(){
        sut.fetchMenu()
        let expected = "Continue"
        if let meals = sut.menu?.categories.first {
            for index in 0...6 - 1 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
        }
        XCTAssertEqual(sut.selectionDescription,expected, "The description value is incorrect")
    }
    
    func testExtraPriceWhenMealsAreInLimitAndOneExtra(){
        sut.fetchMenu()
        var expected = 0.0
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6 - 1 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
            if let drinks = sut.menu?.categories[safe: 1]{
                if let drink = drinks.meals?.first {
                    sut.add(product: drink)
                    expected += drink.price
                }
            }
            XCTAssertEqual(sut.extraPrice, expected , "The extra ammount is incorrect")
        }
    }
    
    
    func testExtraPriceWhenMealsUnderLimitAndNoExtra(){
        sut.fetchMenu()
        let expected = 0.0
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6 - 2 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
            XCTAssertEqual(sut.extraPrice, expected , "The extra ammount is incorrect")
        }
    }
    
    func testSelectionDescriptionMealsAreUnderLimitAndNoExtra(){
        sut.fetchMenu()
      
        if let meals = sut.menu?.categories.first {
            for index in 0...6 - 2 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
        }
        let expected = "Add \(6 - sut.mainDishes.count) More Meals to Continue"
        XCTAssertEqual(sut.selectionDescription,expected, "The description value is incorrect")
    }
    
    
    
    func testExtraPriceWhenMealsUnderLimitAndOneExtra(){
        sut.fetchMenu()
        var expected = 0.0
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6 - 2 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
            if let drinks = sut.menu?.categories[safe: 1]{
                if let drink = drinks.meals?.first {
                    sut.add(product: drink)
                    expected += drink.price
                }
            }
            
            XCTAssertEqual(sut.extraPrice, expected , "The extra ammount is incorrect")
        }
    }
    
    func testSelectionDescriptionMealsAreUnderLimitAndOneExtra(){
        sut.fetchMenu()
      
        if let meals = sut.menu?.categories.first {
            for index in 0...6 - 2 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
        }
        if let drinks = sut.menu?.categories[safe: 1]{
            if let drink = drinks.meals?.first {
                sut.add(product: drink)
            }
        }
        let expected = "Add \(6 - sut.mainDishes.count) More Meals to Continue"
        XCTAssertEqual(sut.selectionDescription,expected, "The description value is incorrect")
    }
    

    
    func testExtraPriceWithOnlyExtras(){
        sut.fetchMenu()
        var expected = 0.0
        if let drinks = sut.menu?.categories[safe: 1]{
            if let drink = drinks.meals?.first {
                sut.add(product: drink)
                expected += drink.price
            }
        }
        if let desserts = sut.menu?.categories[safe: 2]{
            if let dessert = desserts.meals?.first {
                sut.add(product: dessert)
                expected += dessert.price
            }
        }
        XCTAssertEqual(expected, sut.extraPrice, "The extra ammount is incorrect")
    }
    
    
    func testSelectionDescriptionWithOnlyExtras(){
        sut.fetchMenu()
      
        if let drinks = sut.menu?.categories[safe: 1]{
            if let drink = drinks.meals?.first {
                sut.add(product: drink)
            }
        }
        if let desserts = sut.menu?.categories[safe: 2]{
            if let dessert = desserts.meals?.first {
                sut.add(product: dessert)
            }
        }
        let expected = "Add \(6) More Meals to Continue"
        XCTAssertEqual(sut.selectionDescription,expected, "The description value is incorrect")
    }

    func testIsReadyWhenMealsAreOverLimit() {
        sut.fetchMenu()
        let expected = true
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6{
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
        }
        XCTAssertEqual(sut.isReady,expected, "The menu selection state is incorrect")
    }
    
    func testIsReadyWhenMealsAreInLimit() {
        sut.fetchMenu()
        let expected = true
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6 - 1 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
        }
        XCTAssertEqual(sut.isReady,expected, "The menu selection state is incorrect")
    }
    
    func testIsReadyWhenMealsAreUnderLimit() {
        sut.fetchMenu()
        let expected = false
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6 - 2 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
        }
        XCTAssertEqual(sut.isReady,expected, "The menu selection state is incorrect")
    }
    
    func testIsReadyWhenMealsAreUnderLimitWithExtras() {
        sut.fetchMenu()
        let expected = false
        if let meals = sut.menu?.categories.first, meals.meals?.count ?? 0 >= 6 {
            for index in 0...6 - 2 {
                if let meal = meals.meals?[safe:index] {
                    sut.add(product: meal)
                }
            }
        }
        if let drinks = sut.menu?.categories[safe: 1]{
            if let drink = drinks.meals?.first {
                sut.add(product: drink)
            }
        }
        
        XCTAssertEqual(sut.isReady,expected, "The menu selection state is incorrect")
    }
    
    
}
