//
//  Overview.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import SwiftUI

struct Overview: View {
  @EnvironmentObject var todo: Todo
  
  var lastTodoCheck:  (time: String, title: String) {
    guard let last = self.todo.todoChecks.last else {
      return (time: "yyyy/MM/dd", title: "title")
    }
    
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    let date = last.creationDate!
    let dateString = dateFormatter.string(from: date)
    return (time: dateString, title: todo.title)
  }
  
  var body: some View {
    CommonView (
      imageContent:
        ZStack {
          Image("background-firework")
            .resizable()
            .scaledToFill()
            .offset(x: 0, y: 0)
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
        VStack(spacing: 4) {
          Text(lastTodoCheck.time)
            .foregroundColor(.black)
          Text("完成了第\(todo.todoChecks.count)次")
            .foregroundColor(.black)
          Spacer()
          Spacer()
          Text(lastTodoCheck.title)
            .font(.system(size: 32))
            .foregroundColor(.black)
        }.frame(height: 100)
        Spacer()
        Spacer()
        VStack(spacing: 16) {
          ActionButton(action: {
            todo.continueTodo()
          }, color: .action, text: "繼續")
          ActionButton(action: {
            //          todo.createTodoTitle(title)
          }, color: .secondary, text: "換一件事")
        }

        Spacer()
      }
    )
//    ZStack {
//      Image("background-firework")
//        .resizable()
//        .scaledToFill()
//        .frame(minWidth: 384, minHeight: 880)
//        .offset(x: 0, y: -380)
//        .scaledToFill()
//        .scaleEffect(0.65)
//        .edgesIgnoringSafeArea(.all)
//
//
//      VStack {
//        Spacer()
//        VStack {
//          Spacer()
//          VStack(spacing: 5) {
//            Text("2023/10/04").font(.system(size: 20)).foregroundColor(.black)
//            Text("完成了第一次").font(.system(size: 20)).foregroundColor(.black)
//          }
//          Spacer()
//          Text("Todo Name").font(.system(size: 32)).foregroundColor(.black)
//          Spacer()
//          VStack(spacing: 15){
//
//            Button(action: {}) {
//              Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 276, height: 81)
//                .background(Color(red: 0, green: 0.58, blue: 0.73))
//                .cornerRadius(40)
//                .overlay(
//                  Text("繼續").font(.system(size: 24)).foregroundColor(.white)
//                )
//            }
//            Button(action: {}) {
//              Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 276, height: 81)
//                .background(Color(red: 0.32, green: 0.32, blue: 0.32))
//                .cornerRadius(40)
//                .overlay(
//                  Text("換一件事").font(.system(size: 24)).foregroundColor(.white)
//                )
//            }
//          }
//          Spacer()
//        }
//        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 2)
//        .background(Color(red: 0.98, green: 0.96, blue: 0.93))
//        .cornerRadius(50)
//      }
//    }
  }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
      @ObservedObject var todo = Todo(userRecord: nil, onInitSuccess: {})
      Overview().environmentObject(todo)
    }
}
