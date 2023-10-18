//
//  ActionButton.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/16.
//

import SwiftUI

enum ActionButtonColor {
  case action
  case secondary
  
  var colorValue: Color {
    switch self {
    case .action:
      return Color("primary")
    case .secondary:
      return Color("gray")
    }
  }
}

struct ActionButton: View {
  var action: () -> Void
  var color: ActionButtonColor
  var text: String
  
    var body: some View {
      Button(action: action) {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 276, height: 81)
          .background(color.colorValue)
          .cornerRadius(40)
          .overlay(
            Text(text).font(.system(size: 24)).foregroundColor(.white)
          )
      }
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
      ActionButton(action: {}, color: .action, text: "123")
    }
}
