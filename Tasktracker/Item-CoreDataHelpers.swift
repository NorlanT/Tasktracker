//
//  Item-CoreDataHelpers.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/27/21.
//

import Foundation

extension Item {
   
   enum SortOrder {
      case optimized, title, creationDate
   }
   
   
   // To deal with Core Data optionals. also is a GET only.
   var itemTitle: String {
      title ?? "New Item"
   }
   
   var itemDetail: String {
      detail ?? ""
   }
   
   var itemCreationDate: Date {
      creationDate ?? Date()
   }
   
   static var example: Item {
      let controller = DataController(inMemory: true)
      let viewContext = controller.container.viewContext
      
      let item = Item(context: viewContext)
      item.title = "Example Item"
      item.detail = "This is an example item"
      item.priority = 3
      item.creationDate = Date()
      
      return item
   }
   
}//Ext
