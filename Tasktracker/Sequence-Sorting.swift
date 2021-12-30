//
//  Sequence-Sorting.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/29/21.
//

import Foundation
import UIKit

extension Sequence {
   
   func sorted<Value>(by keyPath: KeyPath<Element, Value>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
      try self.sorted {
         try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
      }
   }//func
   
   
   func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
      self.sorted(by: keyPath, using: < )
   }
   
   
   func sorted(by sortDescriptor: NSSortDescriptor) -> [Element] {
      self.sorted {
         sortDescriptor.compare($0, to: $1) == .orderedAscending
      }
   }//func
   
// Not using this one, but is quite nice
   func sorted(by sortDescriptor: [NSSortDescriptor]) -> [Element] {
      self.sorted {
         for descriptor in sortDescriptor {
            switch descriptor.compare($0, to: $1) {
            case .orderedAscending:
               return true
            case .orderedDescending:
               return false
            case .orderedSame:
               continue
            }
         }
         
         return false
      }
   }//func
   
   
}//ext
