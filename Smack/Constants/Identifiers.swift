//
//  Identifiers.swift
//  Smack
//
//  Created by Katherine Ebel on 11/14/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

enum Identifier: String {
  case toLogin
  case toAvatarPicker
  case unwindToChannel
  case unwindFromCreateAccount
}

enum ReuseIdentifier: String {
  case avatarCell
}

struct Theme {
  static let purple = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)
}

enum SmackNotification: String {
  case userDataDidChange
  
  var notificationName: Notification.Name {
    switch self {
    case .userDataDidChange: return Notification.Name(rawValue: "userDataDidChangeØ")
    }
  }
}
