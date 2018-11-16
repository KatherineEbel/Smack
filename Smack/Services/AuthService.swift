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

enum Endpoint {
  case register
  case login
  
  func url() -> String {
    let baseURL = "https://mac-dev-chat.herokuapp.com/v1/"
    switch self {
      case .register: return "\(baseURL)account/register"
      case .login: return "\(baseURL)account/login"
    }
  }
  
  func headers(authRequired: Bool = false) -> [String: String] {
    var headers = ["Content-Type": "application/json; charset=utf-8"]
    if authRequired {
      // TODO:
    }
    return headers
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
    let body: [String: Any] = [
      "email": email,
      "password": password
    ]
    let endpoint = Endpoint.login
    Alamofire.request(endpoint.url(), method: .post, parameters: body, encoding: JSONEncoding.default, headers: endpoint.headers()).responseData { response in
      switch response.result {
        case .success(let data):
          do {
            let result = try JSONDecoder().decode(LoginResponse.self, from: data)
            self.userEmail = result.user
            self.authToken = result.token
            completion(true)
          } catch {
            print(error)
            completion(false)
          }
        case .failure(let error):
          print(error)
          completion(false)
      }
    }
  }
}
