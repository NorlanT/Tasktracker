//
//  TasktrackerApp.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/27/21.
//

import SwiftUI

@main
struct TasktrackerApp: App {
   
   @StateObject var dataController: DataController
   
   init() {
      let dataController = DataController()
      _dataController = StateObject(wrappedValue: dataController)
   }
   
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environment(\.managedObjectContext, dataController.container.viewContext)
              .environmentObject(dataController)
        }
    }
}
