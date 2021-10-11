//
//  ProductCell.swift
//  MenuTest
//
//  Created by Luis Barrios on 9/10/21.
//

import SwiftUI


struct ProductCell: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "circle.inset.filled") .font(Font.system(.title2).bold())
                }else{
                    Spacer()
                    Image(systemName: "circle").font(Font.system(.title2).bold())
                }
            }
        }
    }
}
