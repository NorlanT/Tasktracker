//
//  Binding-onChange.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/28/21.
//

import SwiftUI

extension Binding {
   
   func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
      Binding(
         get: { self.wrappedValue },
         set: { newValue in
            self.wrappedValue = newValue
            handler()
         }
      )
   }//func
   
}//Ext
