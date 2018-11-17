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
  var avatar: Avatar
  var name: String
  var email: String
  
  static func create(fromResponse response: CreateUserResponse) -> User {
    let avatar = Avatar.avatar(fromName: response.avatarName, andColor: response.avatarColor)
    return User(id: response._id, avatar: avatar, name: response.name, email: response.email)
  }
}
