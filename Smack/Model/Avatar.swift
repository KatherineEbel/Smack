//
//  Avatar.swift
//  Smack
//
//  Created by Katherine Ebel on 11/16/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

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
  
  init(id: Int, type: AvatarType, color: String? = "[0.5, 0.5, 1]") {
    self.id = id
    self.type = type
    self.color = color
  }
  static func avatar(fromName name: String, andColor color: String?) -> Avatar {
    let type: AvatarType = name.range(of: "dark") != nil ? .dark : .light
    let id = name.range(of: "0") != nil ? 0 : 1
    return Avatar(id: id, type: type, color: color)
  }
  
  func colorFromComponents() -> UIColor {
    guard let color = color else { return UIColor.lightGray }
    let scanner = Scanner(string: color)
    let skipped = CharacterSet(charactersIn: "[], ")
    let comma = CharacterSet(charactersIn: ",")
    scanner.charactersToBeSkipped = skipped
    var r, g, b, a: NSString?
    scanner.scanUpToCharacters(from: comma, into: &r)
    scanner.scanUpToCharacters(from: comma, into: &g)
    scanner.scanUpToCharacters(from: comma, into: &b)
    scanner.scanUpToCharacters(from: comma, into: &a)
    let defaultColor = UIColor.lightGray
    guard let rUnwrapped = r else { return defaultColor }
    guard let gUnwrapped = g else { return defaultColor }
    guard let bUnwrapped = b else { return defaultColor }
    guard let aUnwrapped = a else { return defaultColor }
    
    
    let rFloat = CGFloat(rUnwrapped.doubleValue)
    let gFloat = CGFloat(gUnwrapped.doubleValue)
    let bFloat = CGFloat(bUnwrapped.doubleValue)
    let aFloat = CGFloat(aUnwrapped.doubleValue)
    
    return UIColor(displayP3Red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
  }
}
