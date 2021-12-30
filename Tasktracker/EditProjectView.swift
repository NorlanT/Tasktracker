//
//  EditProjectView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/28/21.
//

import SwiftUI

struct EditProjectView: View {
   let project: Project
   
   @EnvironmentObject var dataController: DataController
   @Environment(\.presentationMode) var presentationMode
   
   @State private var title: String
   @State private var detail: String
   @State private var color: String
   
   @State private var showingDeleteConfirm = false
   
   let colorColumns = [
      GridItem(.adaptive(minimum: 44))
   ]
   
   init(project: Project) {
      self.project = project
      
      _title = State(wrappedValue: project.projectTitle)
      _detail = State(wrappedValue: project.projectDetail)
      _color = State(wrappedValue: project.projectColor)
   }//init
   
    var body: some View {
       Form {
          // section 1
          Section(header: Text("Basic Settings")) {
             TextField("Project name", text: $title.onChange(update))
             TextField("Description of this project", text: $detail.onChange(update))
          }//Sec
          
          // section 2
          Section(header: Text("Custom project colors")) {
             LazyVGrid(columns: colorColumns) {
                ForEach(Project.colors, id: \.self) { item in
                   ZStack {
                      Color(item)
                         .aspectRatio(1, contentMode: .fit)
                         .cornerRadius(6)
                      
                      if item == color {
                         Image(systemName: "checkmark.circle")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                      }
                   }//Zs
                   .onTapGesture {
                      color = item
                      update()
                   }
                   
                }//For
             }//LazyVG
             .padding(.vertical)
             
          }//Sec
          
          // section 3
          Section(footer: Text("Closing a project moves it from the Open to Closed tab; deleting it removes the project entirely") ) {
             Button(project.closed ? "Reopen this project" : "Close this project") {
                project.closed.toggle()
                update()
             }//btn
             
             Button("Delete this project") {
                // delete the project
                showingDeleteConfirm.toggle()
             }//btn
             .accentColor(.red)
             
          }//Sec
          
       }//Form
       .navigationTitle("Edit Project")
       .onDisappear(perform: dataController.save)
       .alert(isPresented: $showingDeleteConfirm) {
          Alert(title: Text("Delete project?"), message: Text("Are you sure you want to delete this project? You will also delete all the items it contains."), primaryButton: .default(Text("Delete"), action: delete), secondaryButton: .cancel())
       }
       
    }//body
 
   //MARK: FUNCTIONS
      
      func update() {
         project.title = title
         project.detail = detail
         project.color = color
      }//func
      
      func delete() {
         dataController.delete(project)
         presentationMode.wrappedValue.dismiss()
      }//func
   
}//struct

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
