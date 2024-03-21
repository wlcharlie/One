//
//  CheckView.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import SwiftUI

struct CheckView: View {
  @EnvironmentObject var todo: Todo
  
  var body: some View {
    CommonView (
      imageContent:
        ZStack {
          Image("background-hill")
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
      foreImageContent: EmptyView(),
      panelContent: VStack {
        Spacer()
        Spacer()
//        Text("\($todo.todoChecks.count)")
        Text(todo.title).font(.system(size: 32)).frame(height: 60)
          .foregroundColor(.black)
        Spacer()
        Button(action: {
          todo.createTodoCheck()
        }) {
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
    )
  }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
      @ObservedObject var todo = Todo(userRecord: nil, onInitSuccess: {})
      CheckView().environmentObject(todo)
    }
}
