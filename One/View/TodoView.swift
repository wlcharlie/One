//
//  TodoView.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import SwiftUI

struct TodoView: View {
  @State var todo = ""
  
  
  var body: some View {
    ZStack {
      Image("background-cat")
        .resizable()
        .offset(x: 0, y: -70)
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      
      
      VStack {
        Spacer()
        
        VStack {
          Spacer()
          VStack(spacing: 10) {
            Text("現在想要完成什麼事情嗎").font(.system(size: 24))
            Text("例如, 運動 寫 code").font(.system(size: 24))
          }
          Spacer()
          VStack {
            TextField("", text: $todo)
              .padding(.bottom, 8)
            Rectangle()
              .frame(height: 1)
              .foregroundColor(.gray)
          }
          .frame(width: 260)
          Spacer()
          Button(action: {}) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 276, height: 81)
              .background(Color(red: 0, green: 0.58, blue: 0.73))
              .cornerRadius(40)
              .overlay(
                Text("開始").font(.system(size: 24)).foregroundColor(.white)
              )
          }
          Spacer()
          Text("")
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2)
        .background(Color(red: 0.98, green: 0.96, blue: 0.93))
        .cornerRadius(50)
      }
    }
  }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}
