//
//  Channel.swift
//  Smack
//
//  Created by Katherine Ebel on 11/24/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation

struct Channel: Codable {
  let _id: String
  let name: String
  let description: String
  let __v: Int32?
  
  init(_id: String, name: String, description: String) {
    self._id = _id
    self.name = name
    self.description = description
    self.__v = nil
  }
}
