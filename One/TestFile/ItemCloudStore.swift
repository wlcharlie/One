//
//  ItemCloudStore.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/14.
//

import Foundation
import CloudKit

class ItemCloudStore: ObservableObject {
  @Published var items: [CKRecord] = []
  
  func fetchItems() async throws {
    let cloudContainer = CKContainer.default()
    let publicDatabase = cloudContainer.publicCloudDatabase
    let predicate = NSPredicate(value: true)
    let query = CKQuery(recordType: "Item", predicate: predicate)
    let results = try await publicDatabase.records(matching: query)
    for record in results.matchResults {
      self.items.append(try record.1.get())
    }
  }
  
}
