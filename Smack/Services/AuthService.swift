//
//  AuthService.swift
//  Smack
//
//  Created by Katherine Ebel on 11/15/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation
import Alamofire

enum UserDefaultKeys: String {
  case loggedInKey
  case tokenKey
  case userEmail
  case avatarName = "smackProfileIcon"
  case avatarColor = "[0.5, 0.5, 0.5, 1]"
}



typealias CompletionHandler = (_ Success: Bool) -> ()

class AuthService {
  static let instance = AuthService()
  private init() {}
  
  let defaults = UserDefaults.standard
  
  var isLoggedIn: Bool {
    get {
      return defaults.bool(forKey: UserDefaultKeys.loggedInKey.rawValue)
    }
    set {
      defaults.set(newValue, forKey: UserDefaultKeys.loggedInKey.rawValue)
    }
  }
  
  var authToken: String {
    get {
      return defaults.value(forKey: UserDefaultKeys.tokenKey.rawValue) as! String
    }
    set {
      defaults.set(newValue, forKey: UserDefaultKeys.tokenKey.rawValue)
    }
  }
  
  var userEmail: String {
    get {
      return defaults.value(forKey: UserDefaultKeys.userEmail.rawValue) as? String ?? ""
    }
    set {
      defaults.set(newValue, forKey: UserDefaultKeys.userEmail.rawValue)
    }
  }
  
  func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
    let body: [String: Any] = [
      "email": email.lowercased(),
      "password": password
    ]
    let endpoint = SmackEndpoint.register
    Alamofire.request(endpoint.url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: endpoint.headers()).responseString { response in
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
    let endpoint = SmackEndpoint.login
    Alamofire.request(endpoint.url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: endpoint.headers()).responseData { response in
      switch response.result {
        case .success(let data):
          do {
            let result = try JSONDecoder().decode(LoginResponse.self, from: data)
            self.userEmail = result.user
            self.authToken = result.token
            self.isLoggedIn = true
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
  
  func createUser(name: String, email: String,
                  avatarName: String, avatarColor: String,
                  completion: @escaping CompletionHandler) {
    let body: [String: Any] = [
      "name": name,
      "email": email,
      "avatarName": avatarName,
      "avatarColor": avatarColor
    ]
    let endpoint = SmackEndpoint.addUser
    Alamofire.request(endpoint.url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: endpoint.headers(authToken)).responseData { response in
      switch response.result {
        case .success(let data):
          do {
            let user = try JSONDecoder().decode(UserResponse.self, from: data)
            CurrentUserService.instance.setUser(user: User.create(fromResponse: user))
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
  
  func findUserByEmail(completion: @escaping CompletionHandler) {
    let endpoint = SmackEndpoint.userByEmail
    let path = "\(endpoint.url)\(userEmail)"
    Alamofire.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: endpoint.headers(authToken)).responseData { responseData in
      switch responseData.result {
        case .success(let data):
          do {
            let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
            CurrentUserService.instance.setUser(user: User.create(fromResponse: userResponse))
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
