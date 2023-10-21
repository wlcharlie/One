//
//  ErrorMsg.swift
//  One
//
//  Created by Charlie Chiou on 2023/10/20.
//

import Foundation

struct ErrorMsg: Error {
  let msg: String
  
  init(_ msg: String) {
    self.msg = msg
  }
}
