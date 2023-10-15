//
//  ControllerView.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/15.
//

import SwiftUI

struct ControllerView: View {
  @ObservedObject var user = User()
    var body: some View {
        NameView()
        .environmentObject(user)
    }
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerView()
    }
}
