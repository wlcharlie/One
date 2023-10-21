//
//  ControllerView.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/15.
//

import SwiftUI

struct ControllerView: View {
  @ObservedObject var user: User
  @ObservedObject var todo: Todo
  
  init()  {
    let group = DispatchGroup()
    group.enter()
    let _user = User(onInitSuccess: {
      print("User init")
      group.leave()
    })
    self.user = _user
    group.wait()
    group.enter()
    self.todo = Todo(userRecord: _user.userRecord,onInitSuccess: {
      print("Todo init")
      group.leave()
    })
    group.wait()
    group.notify(queue: .main){
      print("done")
    }
  }
  
  var currentView: some View   {
    if user.name == "" {
      return AnyView(NameView())
    } else if todo.title == "" {
      return AnyView(TodoView())
    } else if todo.todoChecks.count == 0 || todo.continueFlag {
      return AnyView(CheckView())
    } else if todo.todoChecks.count > 0 {
      return AnyView(Overview())
    } else {
      return AnyView(ErrorView())
    }
  }
  
  var body: some View {
    Group {
      currentView
    }
      .environmentObject(user)
      .environmentObject(todo)
  }
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerView()
    }
}
