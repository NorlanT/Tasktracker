//
//  HomeView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/27/21.
//

import CoreData
import SwiftUI

struct HomeView: View {
   static let homeTag: String? = "Home"
   
   @EnvironmentObject var dataController: DataController
   
   @FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: true)], predicate: NSPredicate(format: "closed = false")) var projects: FetchedResults<Project>
   let items: FetchRequest<Item>
   
   var projectRows: [GridItem] {
      [GridItem(.fixed(100))]
   }
   
   init() {
      let request: NSFetchRequest<Item> = Item.fetchRequest()
      request.predicate = NSPredicate(format: "completed = false")
      
      request.sortDescriptors = [
         NSSortDescriptor(keyPath: \Item.priority, ascending: false)
      ]
      
      request.fetchLimit = 10
      items = FetchRequest(fetchRequest: request)
   }//init
   
    var body: some View {
       NavigationView {
          ScrollView {

          }//Scroll
          .background(Color.systemGroupedBackground.ignoresSafeArea())
          .navigationTitle("Home")
          
       }//Nav
    }//body
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
