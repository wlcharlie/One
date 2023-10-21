//
//  Todo.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/17.
//

import Foundation
import CloudKit
import Combine

class Todo: ObservableObject {
  private let todoRecordType = "Todo"
  private let todoCheckRecordType = "TodoCheck"
  @Published var userRecord: CKRecord?
  @Published var todoRecord: CKRecord?
  @Published var title: String
  @Published var endAt: Date?
  @Published var todoChecks: [CKRecord] = []
  @Published var continueFlag: Bool = false
  
  
  init(userRecord: CKRecord?, onInitSuccess: @escaping () -> Void) {
    self.userRecord = userRecord ?? nil
    self.title = ""
    self.endAt = nil
    
    Task {
      do {
        let todoRecord = try await getTodo().value
        self.todoRecord = todoRecord!
        self.title = todoRecord!.object(forKey: "title") as! String
        if let endAt = todoRecord!.object(forKey: "endAt") as? Date {
          self.endAt = endAt
        }
        let todoChecks = try await getTodoCheck().value
        self.todoChecks = todoChecks
        onInitSuccess()
      } catch let err as ErrorMsg {
        print("\(err.msg)")
      } catch {
        print("\(error)")
      }
    }
  }

  public func getTodo() -> Future <CKRecord?, ErrorMsg> {
    return Future() { promise in
      guard let userRecord = self.userRecord else {
        promise(Result.failure(ErrorMsg("getTodo - no user record")))
        return
      }
      let container = CKContainer.default()
      let publicDatabase = container.publicCloudDatabase
      
      let predicateTodo = NSPredicate(format: "creatorUserRecordID = %@", userRecord.recordID)
      let queryTodo = CKQuery(recordType: "Todo", predicate: predicateTodo)
      let queryTodoOperation = CKQueryOperation(query: queryTodo)
      
      queryTodoOperation.desiredKeys = ["title", "endAt"]
      
      var todo: CKRecord?
      queryTodoOperation.recordMatchedBlock = { (recordId, result) -> Void in
        if let record = try? result.get() {
          todo = record
        }
      }
      queryTodoOperation.queryResultBlock = { result -> Void in
        switch result {
        case .success(_): promise(Result.success(todo))
        case .failure(let error): promise(Result.failure(ErrorMsg("Failed to get todo data from iCloud - \(error.localizedDescription)")))
        }
      }
      publicDatabase.add(queryTodoOperation)
    }
  }
  
  public func getTodoCheck() -> Future<[CKRecord], ErrorMsg> {
    return Future { promise in
      guard let todoRecord = self.todoRecord else {
        promise(Result.failure(ErrorMsg("getTodoCheck - no todo record")))
        return
      }
      let container = CKContainer.default()
      let publicDatabase = container.publicCloudDatabase
      let predicateTodoCheck = NSPredicate(format: "todo = %@", todoRecord.recordID)
      let queryTodoCheck = CKQuery(recordType: "TodoCheck", predicate: predicateTodoCheck)
      let queryTodoCheckOperation = CKQueryOperation(query: queryTodoCheck)
      
      var todoChecks: [CKRecord] = []
      queryTodoCheckOperation.recordMatchedBlock = { (recordId, result) -> Void in
        if let todoCheck = try? result.get() {
          todoChecks.append(todoCheck)
        }
      }
      
      queryTodoCheckOperation.queryResultBlock = { result -> Void in
        switch result {
        case .success(_): promise(Result.success(todoChecks))
        case .failure(let error): promise(Result.failure(ErrorMsg("Failed to get todo check data from iCloud - \(error.localizedDescription)")))
        }
      }
      
      publicDatabase.add(queryTodoCheckOperation)
    }
  }
  
  public func createTodoTitle(_ title: String) {
    guard title.count > 0 else {
      print("title is too short")
      return
    }
    
    let todoRecord = CKRecord(recordType: self.todoRecordType)
    todoRecord.setValue(title, forKey: "title")
    let container = CKContainer.default()
    let publicDatabase = container.publicCloudDatabase
    publicDatabase.save(todoRecord) { (record, error) -> Void in
      if let error = error {
        print("Error saving record: \(error.localizedDescription)")
      } else {
        print("Todo record saved successfully")
        self.todoRecord = record
        self.title = title
      }
    }
  }
  
  public func createTodoCheck() {
    let todoReference = CKRecord.Reference(record: self.todoRecord!, action: .deleteSelf)
    let todoCheckRecord = CKRecord(recordType: "TodoCheck")
    todoCheckRecord.setValue(todoReference, forKey: "todo")
    
    let container = CKContainer.default()
    let publicDatabase = container.publicCloudDatabase
    publicDatabase.save(todoCheckRecord) { (record, error) -> Void in
      if let error = error {
        print("Error saving todo check record: \(error.localizedDescription)")
      } else {
        print("Todo check record saved successfully")
        DispatchQueue.main.async {
          self.continueFlag = false
          self.todoChecks.append(record!)
        }
      }
    }
  }
  
  public func continueTodo () {
    self.continueFlag = true
  }
}
