//
//  NameView.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import SwiftUI

struct NameView: View {
  @State var username = ""
  
  
    var body: some View {
      ZStack {
        Image("background-night")
          .resizable()
          .scaledToFill()
          .edgesIgnoringSafeArea(.all)
        
        Rectangle()
          .foregroundColor(.clear)
          .background(
            LinearGradient(
              stops: [
                Gradient.Stop(color: Color(red: 0.17, green: 0.17, blue: 0.17), location: 0.00),
                Gradient.Stop(color: Color(red: 0.71, green: 0.37, blue: 0.37).opacity(0), location: 1.00),
              ],
              startPoint: UnitPoint(x: 0.5, y: 0),
              endPoint: UnitPoint(x: 0.5, y: 1)
            )
          )
          .edgesIgnoringSafeArea(.all)
        
        VStack {
          
          Spacer()

          Text("嗨囉").font(.system(size: 24)).foregroundColor(.white)
          Text("請先寫下你的大名吧").font(.system(size: 24)).foregroundColor(.white)
          
          Spacer()
          
          VStack {
            Spacer()
            Text("我是......").font(.system(size: 32))
            Spacer()
            VStack {
              TextField("", text: $username)
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
                  Text("下一步").font(.system(size: 24)).foregroundColor(.white)
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

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
