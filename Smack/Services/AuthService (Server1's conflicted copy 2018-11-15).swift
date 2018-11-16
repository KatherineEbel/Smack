//
//  AuthService.swift
//  Smack
//
//  Created by Katherine Ebel on 11/15/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation
import Alamofire

enum UserDefaultConstants: String {
  case loggedInKey
  case tokenKey
  case userEmail
}

enum ChatEndpoint {
  case base
  case register
  case login
  
  func url() -> String {
    switch self {
    case .base:
      return "https://mac-dev-chat.herokuapp.com/v1/"
    case .register:
      return "\(ChatEndpoint.base.url())account/register"
    case .login:
      return "\(ChatEndpoint.base.url())account/login"
    }
  }
}
let BASE_URL = "https://mac-dev-chat.herokuapp.com/v1/"

let URL_REGISTER = "\(BASE_URL)account/register"

typealias CompletionHandler = (_ Success: Bool) -> ()
class AuthService {
  static let instance = AuthService()
  private init() {}
  
  let defaults = UserDefaults.standard
  
  var isLoggedIn: Bool {
    get {
      return defaults.bool(forKey: UserDefaultConstants.loggedInKey.rawValue)
    }
    set {
      defaults.set(newValue, forKey: UserDefaultConstants.loggedInKey.rawValue)
    }
  }
  
  var authToken: String {
    get {
      return defaults.value(forKey: UserDefaultConstants.tokenKey.rawValue) as! String
    }
    set {
      defaults.set(newValue, forKey: UserDefaultConstants.tokenKey.rawValue)
    }
  }
  
  var userEmail: String {
    get {
      return defaults.value(forKey: UserDefaultConstants.userEmail.rawValue) as! String
    }
    set {
      defaults.set(newValue, forKey: UserDefaultConstants.userEmail.rawValue)
    }
  }
  
  func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
    let lowercaseEmail = email.lowercased()
    let headers = [
      "Content-Type": "application/json; charset=utf-8"
    ]
    let body: [String: Any] = [
      "email": lowercaseEmail,
      "password": password
    ]
    
    Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseString { response in
      switch response.result {
        case .success(let message):
          completion(true)
          print(message)
        case .failure(let error):
          completion(false)
          print(error)
      }
    }
  }
  
  func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
    let lowercaseEmail = email.lowercased()
    let headers = [
      "Content-Type": "application/json; charset=utf-8"
    ]
    let body: [String: Any] = [
      "email": lowercaseEmail,
      "password": password
    ]
    
    Alamofire.request(ChatEndpoint.login.url(), method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
      switch response.result {
        case .success(let json):
          guard let data = response.data else { return }
          
          completion(true)
        case .failure(let error):
          completion(false)
      }
    }
  }
}
