//
//  ProjectHeaderView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/28/21.
//

import SwiftUI

struct ProjectHeaderView: View {
   
   @ObservedObject var project: Project
   
    var body: some View {
        
       HStack {
          VStack(alignment: .leading) {
             Text(project.projectTitle)
             
             ProgressView(value: project.completionAmount)
                .accentColor(Color(project.projectColor))
          }//VS
          
          Spacer()
          
          NavigationLink(destination: EditProjectView(project: project)) {
             Image(systemName: "square.and.pencil")
                .imageScale(.large)
          }
          
       }//HS
       .padding(.bottom, 10)
       
    }//body
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
       ProjectHeaderView(project: Project.example)
    }
}
