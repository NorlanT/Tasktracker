//
//  HomeView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/27/21.
//

import SwiftUI

struct HomeView: View {
   static let homeTag: String? = "Home"
   
   @EnvironmentObject var dataController: DataController
   
    var body: some View {
       NavigationView {
          VStack {
             Button("Add Data") {
                dataController.deleteAll()
                try? dataController.createSampleData()
             }
          }
          .navigationTitle("Home")
          
       }//Nav
    }//body
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
