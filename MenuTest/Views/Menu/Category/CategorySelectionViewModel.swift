//
//  CategorySelectionViewModel.swift
//  MenuTest
//
//  Created by Luis Barrios on 9/10/21.
//

import SwiftUI


public class CategorySelectionViewModel:ObservableObject {
    
    private let _menu:Menu?
   
    private let delegate: SelectionDelegate
    var menu: Menu?{
        get{
            return self._menu
        }
        set{
            
        }
        
    }
    var selection: [Product]{
        get{
            return self.delegate.selection
        }
        set{
            
        }
    }
 
    init(menu:Menu?,delegate:SelectionDelegate){
        self._menu = menu
        self.delegate = delegate
      
    }
    
    func toggleSelection(meal: Product){
        if self.selection.contains(meal){
            self.delegate.remove(product: meal)
        }else{
            self.delegate.add(product: meal)
        }
    }
    
}
