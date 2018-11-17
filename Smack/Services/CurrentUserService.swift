//
//  CurrentUserService.swift
//  Smack
//
//  Created by Katherine Ebel on 11/15/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation

class CurrentUserService {
  static let instance = CurrentUserService()
  private init() {}
  public private(set) var user: User?
  
  func setUser(user: User) {
    self.user = user
  }
  
  func setAvatar(avatar: Avatar) {
    user?.avatar = avatar
  }
}
