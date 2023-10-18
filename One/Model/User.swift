//
//  User.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/15.
//

import Foundation
import CloudKit

class User: ObservableObject {
  @Published var userRecord: CKRecord? = nil
  @Published var name: String = ""

  
  init(onInitSuccess: @escaping () -> Void) {
    let container = CKContainer.default()
    
    container.fetchUserRecordID { (recordID, error) in
      if let error = error {
        print("Error fetching user record ID: \(error.localizedDescription)")
      } else if let recordID = recordID {

        print("User record ID: \(recordID.recordName)")
        
        // find user in publicConatiner - Users
        
        self.findMe(recordID) { name in
          if name != "" {
            self.name = name
            onInitSuccess()
            print("User name: \(self.name)")
          } else {
            onInitSuccess()
            print("New User or User without name")
          }
        }
      }
    }
  }
  
  private func findMe(_ recordID: CKRecord.ID, completion: @escaping (String) -> Void) {
    let cloudContainer = CKContainer.default()
    let publicDatabase = cloudContainer.publicCloudDatabase
    
    
    publicDatabase.fetch(withRecordID: recordID) { (result, error) -> Void in
      if let record = result {
        print(record)
        // check is recordType is "Users"
        if record.recordType != "Users" {
          print("Error: init User found at another recordType: \(record.recordType)")
          completion("")
          return
        }
        
        self.userRecord = record
        let name = record.object(forKey: "name") as? String ?? ""
        completion(name)
      } else if let error = error {
        print("Error fetching user record: \(error.localizedDescription)")
        completion("")
      }
    }
  }
  
  public func updateUsername(newUsername: String) {
    let newName = newUsername
    // len > 0
    guard newName.count > 0 else {
      print("New username length should larger than 0")
      return
    }
    
    guard self.userRecord != nil else {
      print("User has no record")
      return
    }
    
    let newUserRecord = self.userRecord!
    
    newUserRecord.setValue(newName, forKey: "name")
    let publiceDatabase = CKContainer.default().publicCloudDatabase
    publiceDatabase.save(newUserRecord) { (_, error) -> Void in
      if error != nil {
        print("Save username error: \(error.debugDescription)")
      } else {
        self.name = newUsername
        print("Save username success!")
      }
    }
  }
}
