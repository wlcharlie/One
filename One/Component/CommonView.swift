//
//  CommonView.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/16.
//

import SwiftUI

struct CommonView<IC: View, FC: View, PC: View>: View {
  let imageContent: IC
  let foreImageContent: FC
  let panelContent: PC
  
  
    var body: some View {
      ZStack {
        VStack {
          VStack {
            // image area
            imageContent
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
            .background(Color.blue)
            .ignoresSafeArea()
          VStack {
            //empty
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55)
            .background(Color(red: 0.98, green: 0.96, blue: 0.93))
            .cornerRadius(50)
        }

        VStack(spacing: 0) {
          VStack {
            //text area
            foreImageContent
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            .ignoresSafeArea()
          VStack {
            //free area
            panelContent
          }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            .background(Color(red: 0.98, green: 0.96, blue: 0.93))
            .cornerRadius(50)
        }
      }
    }
}

struct CommonView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        CommonView(
          imageContent:
            Image("background-hill")
            .resizable()
            .scaledToFill(),
          foreImageContent: Text("123"),
          panelContent: Text("123")
        )
          .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
          .previewDisplayName("iPhone 14")
        CommonView(
          imageContent:
            Image("background-hill")
            .resizable()
            .scaledToFill(),
          foreImageContent: Text("123"),
          panelContent: Text("123")
        )
          .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
          .previewDisplayName("iPad Air (5th generation)")
      }
    }
}
