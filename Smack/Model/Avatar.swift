//
//  Avatar.swift
//  Smack
//
//  Created by Katherine Ebel on 11/16/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation

enum AvatarType: String {
  case dark
  case light
}

struct Avatar {
  let id: Int
  var type: AvatarType
  var color: String?
  var imageName: String {
    return "\(type.rawValue)\(id)"
  }
  
  static func avatar(fromName name: String, andColor color: String) -> Avatar {
    let type: AvatarType = name.range(of: "dark") != nil ? .dark : .light
    let id = name.range(of: "0") != nil ? 0 : 1
    return Avatar(id: id, type: type, color: color)
  }
}
