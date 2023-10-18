//
//  Todo.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/17.
//

import Foundation
import CloudKit

class Todo: ObservableObject {
  private let recordType = "Todo"
  @Published var userRecord: CKRecord?
  @Published var todoRecord: CKRecord?
  @Published var title: String
  @Published var endAt: Date?
  
  init(userRecord: CKRecord?) {
    self.userRecord = userRecord ?? nil
    self.title = ""
    self.endAt = nil
    
  
    getTodo()
  }

  public func getTodo() {
    guard let userRecord = self.userRecord else {
      print("No userRecord")
      return
    }
    let container = CKContainer.default()
    let publicDatabase = container.publicCloudDatabase
    let predicate = NSPredicate(format: "creatorUserRecordID = %@", userRecord.recordID)
    let query = CKQuery(recordType: "Todo", predicate: predicate)
    let queryOperation = CKQueryOperation(query: query)
    queryOperation.desiredKeys = ["title", "endAt"]
    queryOperation.recordMatchedBlock = { (recordId, result) -> Void in
      if let todo = try? result.get() {
        DispatchQueue.main.async {
          
          self.title = todo.object(forKey: "title") as! String
          if let endAt = todo.object(forKey: "endAt") as? Date {
            self.endAt = endAt
          }
        }
      }
    }
    queryOperation.queryResultBlock = { result -> Void in
      switch result {
      case .success(_): print("Successfully retrieve the todo from iCloud.")
      case .failure(let error): print("Failed to get data from iCloud - \(error.localizedDescription)")
      }
    }
    publicDatabase.add(queryOperation)
  }
  
  public func createTodoTitle(_ title: String) {
    guard title.count > 0 else {
      print("title is too short")
      return
    }
    
    let todoRecord = CKRecord(recordType: self.recordType)
    todoRecord.setValue(title, forKey: "title")
    let container = CKContainer.default()
    let publicDatabase = container.publicCloudDatabase
    publicDatabase.save(todoRecord) { (record, error) -> Void in
      if let error = error {
        print("Error saving record: \(error.localizedDescription)")
      } else {
        print("Record saved successfully")
        self.todoRecord = record
        self.title = title
      }
    }
  }
}
