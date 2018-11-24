//
//  CreateUserResponse.swift
//  Smack
//
//  Created by Katherine Ebel on 11/15/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
  let __v: Int32
  let avatarColor: String
  let avatarName: String
  let email: String
  let name: String
  let _id: String
}
