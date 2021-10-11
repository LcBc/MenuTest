//
//  File.swift
//  MenuTest
//
//  Created by Luis Barrios on 8/10/21.
//

import Foundation


extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}
