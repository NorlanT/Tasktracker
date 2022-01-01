//
//  SelectSomethingView.swift
//  Tasktracker
//
//  Created by Norlan Tibanear on 12/30/21.
//

import SwiftUI

struct SelectSomethingView: View {
    var body: some View {
        Text("Please select domething from the menu to begin")
          .italic()
          .foregroundColor(.secondary)
    }//body
}

struct SelectSomethingView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSomethingView()
    }
}
