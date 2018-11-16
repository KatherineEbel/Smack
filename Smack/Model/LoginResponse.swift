//
//  LoginResponse.swift
//  Smack
//
//  Created by Katherine Ebel on 11/15/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation

struct LoginResponse: Decodable {
  let user: String
  let token: String
}
