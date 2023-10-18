//
//  NameView.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import SwiftUI

struct NameView: View {
  @EnvironmentObject var user: User
  @State var username: String = ""

    var body: some View {
      CommonView (
        imageContent:
          ZStack {
            Image("background-cat2")
              .resizable()
              .scaledToFill()
              .offset(x: 0, y: 20)
              .edgesIgnoringSafeArea(.all)
            Rectangle()
              .foregroundColor(.clear)
              .background(
                LinearGradient(
                  stops: [
                    Gradient.Stop(color: Color(red: 0, green: 0.15, blue: 0.28).opacity(0.9), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.25, green: 0.57, blue: 0.87).opacity(0), location: 1.00),
                  ],
                  startPoint: UnitPoint(x: 0.5, y: 0),
                  endPoint: UnitPoint(x: 0.5, y: 1)
                )
              )
              .edgesIgnoringSafeArea(.all)
          }

        ,
        foreImageContent: Group {
          Text("嗨囉").font(.system(size: 24)).foregroundColor(.white)
          Text("請先寫下你的大名吧").font(.system(size: 24)).foregroundColor(.white)
        },
        panelContent: VStack {
          Spacer()
          Text("我是......").font(.system(size: 32)).frame(height: 60)
          Spacer()
          VStack {
            TextField("", text: $username)
              .padding(.bottom, 8)
            Rectangle()
              .frame(height: 1)
              .foregroundColor(Color("dark"))
          }.frame(width: 261)
          .foregroundColor(.black)
          .padding(.vertical, 20)
          Spacer()
          ActionButton(action: {
            user.updateUsername(newUsername: username)
          }, color: .action, text: "下一步")
          Spacer()
        }
      )
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
      @ObservedObject var user = User(onInitSuccess: {})
      Group {
        NameView()
          .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
          .previewDisplayName("iPhone 14")
        NameView()
          .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
          .previewDisplayName("iPad Air (5th generation)")
      }
      .environmentObject(user)

    }
}
