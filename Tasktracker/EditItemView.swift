//
//  EditItemView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/28/21.
//

import SwiftUI

struct EditItemView: View {
   let item: Item
   
   @EnvironmentObject var dataController: DataController
   
   @State private var title: String
   @State private var detail: String
   @State private var priority: Int
   @State private var completed: Bool
   
   init(item: Item) {
      self.item = item
      
      _title = State(wrappedValue: item.itemTitle)
      _detail = State(wrappedValue: item.itemDetail)
      _priority = State(wrappedValue: Int(item.priority))
      _completed = State(wrappedValue: item.completed)
   }//init
   
    var body: some View {
        
       Form {
          Section(header: Text("Basic Settings")) {
             TextField("Item Name", text: $title.onChange(update))
             TextField("Description", text: $detail.onChange(update))
          }//Sect
          
          Section(header: Text("Priority")) {
             Picker("Priority", selection: $priority.onChange(update)) {
                Text("Low").tag(1)
                Text("Medium").tag(2)
                Text("High").tag(3)
             }
             .pickerStyle(SegmentedPickerStyle())
          }//Sect
          
          Section {
             Toggle("Mark Completed", isOn: $completed.onChange(update))
          }//Sect
          
       }//form
       .navigationTitle("Edit Item")
       .onDisappear(perform: dataController.save)
       
    }//body
   
   //MARK: FUNCTIONS
      
      // Reversing the init to pass the info back to the previous screen
      func update() {
         item.project?.objectWillChange.send()
         
         item.title = title
         item.detail = detail
         item.priority = Int16(priority)
         item.completed = completed
      }//func
   
}//struct

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemView(item: Item.example)
    }
}
