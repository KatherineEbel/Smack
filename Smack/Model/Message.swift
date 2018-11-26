//
//  Message.swift
//  Smack
//
//  Created by Katherine Ebel on 11/25/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation

struct Message: Codable {
  let _id: String
  let messageBody: String
  let userId: String
  let channelId: String
  let userName: String
  let userAvatar: String
  let __v: Int32
  let timeStamp: String
}
