//
//  CategorySelectionView.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import SwiftUI

struct CategorySelectionView: View {
    
//    @Binding var menu:Menu?
//    @Binding var selection:[Product]
   // var delegate:SelectionDelegate?
    @ObservedObject var viewModel:CategorySelectionViewModel
    var body: some View {
        
        if let menu = viewModel.menu {
            List{
                ForEach(menu.categories){ cat in
                    if let meals =  cat.meals {
                        Section(header:Text(cat.title)){
                            ForEach(meals){ meal in
                                ProductCell(title: meal.name, isSelected: viewModel.selection.contains(meal)) {
                                    viewModel.toggleSelection(meal: meal)
                                }
                                
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
}
struct CategorySelectionView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let viewModel = MenuSelectionViewModel(with: defaultMenuDataManager, and: defaulMaxProducts)
        if let menu = viewModel.fetchMenu()  {
            CategorySelectionView(viewModel: CategorySelectionViewModel(menu: menu, delegate: viewModel))
            
        }else{
            Text("Could not draw view")
        }
        
    }
    
    
}
