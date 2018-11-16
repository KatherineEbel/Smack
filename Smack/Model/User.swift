//
//  User.swift
//  Smack
//
//  Created by Katherine Ebel on 11/15/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation

struct User {
  let id: String
  var avatarName: String
  var avatarColor: String
  var name: String
  var email: String
  
  static func create(fromResponse response: CreateUserResponse) -> User {
    return User(id: response._id, avatarName: response.avatarName, avatarColor: response.avatarColor, name: response.name, email: response.email)
  }
}
