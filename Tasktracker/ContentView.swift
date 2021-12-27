//
//  ContentView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       TabView {
          HomeView()
             .tabItem {
                Image(systemName: "house")
                Text("Home")
             }
          
          ProjectView(showClosedProjects: false)
             .tabItem {
                Image(systemName: "list.bullet")
                Text("Open")
             }
          
          ProjectView(showClosedProjects: true)
             .tabItem {
                Image(systemName: "checkmark")
                Text("Closed")
             }
          
       }
    }//body
}

struct ContentView_Previews: PreviewProvider {
   static var dataController = DataController.preview
   
    static var previews: some View {
       ContentView()
          .environment(\.managedObjectContext, dataController.container.viewContext)
          .environmentObject(dataController)
    }
}
