//
//  MessageService.swift
//  Smack
//
//  Created by Katherine Ebel on 11/24/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import Foundation
import Alamofire

class MessageService {
  static let instance = MessageService()
  private init() {}
  var channels = [Channel]()
  
  func getAllChannels(completion: @escaping CompletionHandler) {
    let endpoint = SmackEndpoint.channel
    Alamofire.request(endpoint.url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: endpoint.headers(AuthService.instance.authToken)).responseData { [weak self] responseData in
      switch responseData.result {
        case .success(let data):
          do {
            self?.channels = try JSONDecoder().decode([Channel].self, from: data)
            completion(true)
          } catch {
            completion(false)
          }
        case .failure(let error):
          print(error)
          completion(false)
      }
    }
  }
}
