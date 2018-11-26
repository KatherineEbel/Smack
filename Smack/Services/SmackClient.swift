//
//  SmackClient.swift
//  Smack
//
//  Created by Katherine Ebel on 11/25/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

enum SmackEndpoint {
  case register
  case login
  case addUser
  case userByEmail
  case channel
  case messageByChannel
  
  static let baseURL = "https://mac-dev-chat.herokuapp.com/v1/"
  
  var url: String {
    switch self {
      case .register: return "\(SmackEndpoint.baseURL)account/register"
      case .login: return "\(SmackEndpoint.baseURL)account/login"
      case .addUser: return "\(SmackEndpoint.baseURL)user/add"
      case .userByEmail: return "\(SmackEndpoint.baseURL)user/byEmail/"
      case .channel: return "\(SmackEndpoint.baseURL)channel/"
      case .messageByChannel: return "\(SmackEndpoint.baseURL)message/byChannel/"
    }
  }
  
  func headers(_ token: String? = nil) -> [String: String] {
    var headers = ["Content-Type": "application/json; charset=utf-8"]
    guard let token = token else { return headers }
    headers.updateValue("Bearer \(token)", forKey: "Authorization")
    return headers
  }
}
