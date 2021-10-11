//
//  MenuViewModel.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import Foundation


public protocol SelectionDelegate: AnyObject {
    
    func add(product:Product)
    func remove(product:Product)
    func clearSelection()
    var selection:[Product]{get}
}

public class MenuSelectionViewModel:ObservableObject {
    // MARK: Variables
    @Published private var _menu:Menu?
    private var menuDataManager: MenuDataManager
    var menu: Menu?{
        get{
            return self._menu
        }
        set{
            
        }
        
    }
    @Published private var _selection: [Product] = []
    public var selection: [Product]{
        get{
            return self._selection
        }
        set{
            
        }
    }
    var mainDishes: [Product] {
        get{
            let mainCategory = menu?.categories.first{$0.id == 0}
            return  self._selection.filter{mainCategory?.meals?.contains($0) ?? false }
        }
    }
    
    var sideDishes:[Product]{
        get{
            let mainCategory = menu?.categories.first{$0.id == 0}
            return self._selection.filter{!(mainCategory?.meals?.contains($0) ?? false)}
        }
    }
    
    let maxProducts: Int
    
    @Published  public var _extraPrice = 0.0
    var extraPrice:Double{
        get{
            return self._extraPrice
        }
        
    }
    @Published public var selectionDescription = ""
    @Published public var isReady = false
    
    //MARK: Initialization
    
    init(with dataManager:MenuDataManager, and maxProducts:Int){
        self.menuDataManager = dataManager
        self.maxProducts = maxProducts
        self.selectionDescription = "Add \(maxProducts) More Meals to Continue"
    }
    
    //MARK:  Methods
    
    @discardableResult  func fetchMenu() -> Menu?{
        self._menu = menuDataManager.fetchMenu()
        return   self._menu
    }
    
    func updateSelectionStatus(){
        var tempExtra = 0.0
        
        
        self.isReady = mainDishes.count >= 6
        if mainDishes.count > self.maxProducts {
            tempExtra += mainDishes.suffix(from: maxProducts).reduce(0.0){result, meal in
                result + meal.price
            }
        }
        tempExtra += sideDishes.reduce(0){
            result, meal in
            result + meal.price
        }
        self._extraPrice = tempExtra
        let diff = maxProducts - mainDishes.count
        let formattedPrice = self._extraPrice > 0 ? String(format: "(+ %.2f)", self._extraPrice) : ""
        self.selectionDescription = "\((diff < 1 ? "Continue" : "Add \(diff) More Meals to Continue" ))\( (mainDishes.count >= self.maxProducts ? "\(formattedPrice)" : ""))"
    }
}
//MARK: selectionDelegate Implementation

extension MenuSelectionViewModel: SelectionDelegate{
    public func remove(product: Product) {
        if let index = self._selection.firstIndex(of: product) {
            self._selection.remove(at: index)
        }
        self.updateSelectionStatus()
    }
    
    public func add(product: Product) {
        if (self._selection.first( where: { meal in
            meal == product
        }) == nil) {
            self._selection.append(product)
        }
        self.updateSelectionStatus()
    }
    
    public func clearSelection() {
        self._selection.removeAll()
        self.updateSelectionStatus()
    }
    
}

