//
//  SocketService.swift
//  Smack
//
//  Created by Katherine Ebel on 11/25/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
  static let instance = SocketService()
  let manager: SocketManager
  let socket: SocketIOClient
  
  private override init() {
    manager = SocketManager(socketURL: URL(string: SmackEndpoint.baseURL)!)
    socket = manager.defaultSocket
    super.init()
  }
  
  func establishConnection() {
    socket.connect()
  }
  
  func closeConnection() {
    socket.disconnect()
  }
  
  func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
    socket.emit("newChannel", name, description)
    completion(true)
  }
  
  func getChannel(completion: @escaping CompletionHandler) {
    socket.on("channelCreated") { (dataArray, ack) in
      guard let name = dataArray[0] as? String,
        let description = dataArray[1] as? String,
        let id = dataArray[2] as? String else {
          completion(false)
          return
      }
      
      let channel = Channel(_id: id, name: name, description: description)
      MessageService.instance.channels.append(channel)
      completion(true)
      
    }
  }
}
