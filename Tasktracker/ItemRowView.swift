//
//  ItemRowView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/28/21.
//

import SwiftUI

struct ItemRowView: View {
   
   @ObservedObject var item: Item
   
    var body: some View {
       
       NavigationLink(destination: EditItemView(item: item)) {
          Text(item.itemTitle)
       }
       
    }//body
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
       ItemRowView(item: Item.example)
    }
}
