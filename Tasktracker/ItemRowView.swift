//
//  ItemRowView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/28/21.
//

import SwiftUI

struct ItemRowView: View {
   
   @ObservedObject var project: Project
   @ObservedObject var item: Item
   
   var icon: some View {
      if item.completed {
         return Image(systemName: "checkmark.circle")
            .foregroundColor(Color(project.projectColor))
      } else if item.priority == 3 {
         return Image(systemName: "exclamationmark.triangle")
            .foregroundColor(Color(project.projectColor))
      } else {
         return Image(systemName: "checkmark.circle")
            .foregroundColor(.clear)
      }
      
   }//icon
   
    var body: some View {
       
       NavigationLink(destination: EditItemView(item: item)) {
          Label {
             Text(item.itemTitle)
          } icon: {
             icon
          }
       }
       
    }//body
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
       ItemRowView(project: Project.example, item: Item.example)
    }
}
