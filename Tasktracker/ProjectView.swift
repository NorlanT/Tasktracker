//
//  ProjectView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/27/21.
//

import SwiftUI

struct ProjectView: View {
   static let openTag: String? = "Open"
   static let closeTag: String? = "Closed"
   
   @EnvironmentObject var dataController: DataController
   @Environment(\.managedObjectContext) var managedObjectContext
   
   @State private var showingSortOrder = false
   @State private var sortOrder = Item.SortOrder.optimized
   
   let showClosedProjects: Bool
   
   let projects: FetchRequest<Project>
   
   init(showClosedProjects: Bool) {
      self.showClosedProjects = showClosedProjects
      
      projects = FetchRequest<Project>(entity: Project.entity(),
                     sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate,
                        ascending: false)],
                        predicate: NSPredicate(format: "closed = %d",
                        showClosedProjects))
   }
   
    var body: some View {
       NavigationView {
          Group {
             if projects.wrappedValue.isEmpty {
                Text("There is nothing here right now")
                   .foregroundColor(.secondary)
             } else {
                List {
                   ForEach(projects.wrappedValue) { project in
                      Section(header: ProjectHeaderView(project: project)) {
                         ForEach(project.projectItems(using: sortOrder)) { item in
                            ItemRowView(project: project, item: item)
                         }
                         .onDelete { offsets in
                            let allItems = project.projectItems(using: sortOrder)
                            
                            for offset in offsets {
                               let item = allItems[offset]
                               dataController.delete(item)
                            }
                            
                            
                            dataController.save()
                         }
                         
                         if showClosedProjects == false {
                            Button {
                               withAnimation {
                                  let item = Item(context: managedObjectContext)
                                  item.project = project
                                  item.creationDate = Date()
                                  dataController.save()
                               }
                            } label: {
                               Label("Add New Item", systemImage: "plus")
                            }
                         }
                         
                      }//Set
                   }
                }//List
                .listStyle(InsetGroupedListStyle())
                
             }
          }//Group
         
          .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
          .toolbar {
             ToolbarItem(placement: .navigationBarTrailing) {
                if showClosedProjects == false {
                   Button {
                      withAnimation {
                         let project = Project(context: managedObjectContext)
                         project.closed = false
                         project.creationDate = Date()
                         dataController.save()
                      }
                   } label: {
                      Label("Add Project", systemImage: "plus")
                   }
                }
             }//ToolBarItem
             
             ToolbarItem(placement: .navigationBarLeading) {
                Button {
                   showingSortOrder.toggle()
                } label: {
                   Label("Sort", systemImage: "arrow.up.arrow.down")
                }
             }//ToolBatItem - Leading
            
          }//toolbar
          .actionSheet(isPresented: $showingSortOrder) {
             ActionSheet(title: Text("Sort items"), message: nil, buttons: [
               .default(Text("Optimized")) { sortOrder = .optimized },
               .default(Text("Creation Date")) { sortOrder = .creationDate },
               .default(Text("Title")) { sortOrder = .title }
             ])
          }
          
          SelectSomethingView()
          
       }//Nav
    }//body
   
   
   
}//struct

struct ProjectView_Previews: PreviewProvider {
   static var dataController = DataController.preview
   
    static var previews: some View {
       ProjectView(showClosedProjects: false)
          .environment(\.managedObjectContext, dataController.container.viewContext)
          .environmentObject(dataController)
    }
}
