//
//  CheckView.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import SwiftUI

struct CheckView: View {
  var body: some View {
    ZStack {
      Image("background-hill")
        .resizable()
        .scaledToFill()
        .frame(minWidth: 384, minHeight: 880)
        .offset(x: 100, y: 0)
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      
      
      VStack {
        Spacer()
        VStack {
          Spacer()
          Spacer()
          Text("Todo Name").font(.system(size: 32))
          Spacer()
          Button(action: {}) {
            Circle()
              .foregroundColor(Color(red: 0, green: 0.58, blue: 0.73))
              .frame(width: 80, height: 80)
              .overlay(
                Image(systemName: "checkmark")
                  .foregroundColor(.white)
                  .font(.system(size: 32))
              )
          }
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2)
        .background(Color(red: 0.98, green: 0.96, blue: 0.93))
        .cornerRadius(50)
      }
    }
  }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView()
    }
}
