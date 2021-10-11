//
//  MenuView.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var viewModel = MenuSelectionViewModel(with: defaultMenuDataManager, and: defaulMaxProducts)
    @State var showingAlert = false
    var body: some View {
        NavigationView{
            VStack{
                CategorySelectionView(viewModel: CategorySelectionViewModel(menu: viewModel.menu, delegate: viewModel))
                    .listStyle(SidebarListStyle())
                Button(action: {
                    showingAlert = true
                } ) {
                    Text(viewModel.selectionDescription)
                }.disabled(!viewModel.isReady)
            }.onAppear{
                viewModel.fetchMenu()
            }.navigationTitle("Menu").alert(isPresented: $showingAlert) {
                Alert(
                     title: Text("Important message"),
                     message: Text("This is the end of the demo, have a nice day!"),
                     dismissButton: .default(Text("Got it!"))
                )
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
