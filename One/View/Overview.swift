//
//  Overview.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import SwiftUI

struct Overview: View {
  var body: some View {
    ZStack {
      Image("background-firework")
        .resizable()
        .scaledToFill()
        .frame(minWidth: 384, minHeight: 880)
        .offset(x: 0, y: -380)
        .scaledToFill()
        .scaleEffect(0.65)
        .edgesIgnoringSafeArea(.all)
      
      
      VStack {
        Spacer()
        VStack {
          Spacer()
          VStack(spacing: 5) {
            Text("2023/10/04").font(.system(size: 20))
            Text("完成了第一次").font(.system(size: 20))
          }
          Spacer()
          Text("Todo Name").font(.system(size: 32))
          Spacer()
          VStack(spacing: 15){

            Button(action: {}) {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 276, height: 81)
                .background(Color(red: 0, green: 0.58, blue: 0.73))
                .cornerRadius(40)
                .overlay(
                  Text("繼續").font(.system(size: 24)).foregroundColor(.white)
                )
            }
            Button(action: {}) {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 276, height: 81)
                .background(Color(red: 0.32, green: 0.32, blue: 0.32))
                .cornerRadius(40)
                .overlay(
                  Text("換一件事").font(.system(size: 24)).foregroundColor(.white)
                )
            }
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

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
