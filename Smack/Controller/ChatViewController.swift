//
//  ChatViewController.swift
//  Smack
//
//  Created by Katherine Ebel on 11/14/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit
import PBRevealViewController

class ChatViewController: UIViewController {
  @IBOutlet var menuButton: UIButton!
  @IBOutlet var channelNameLabel: UILabel!
  
  override func viewDidLoad() {
    menuButton.addTarget(self.revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchUpInside)
    NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged), name: SmackNotification.userDataDidChange.notificationName, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(channelSelected), name: SmackNotification.channelSelected.notificationName, object: nil)
    guard AuthService.instance.isLoggedIn else { return }
    AuthService.instance.findUserByEmail { success in
      guard success else { return }
      NotificationCenter.default.post(name: SmackNotification.userDataDidChange.notificationName, object: nil)

    }
  }
  
  @objc func userDataChanged() {
    if AuthService.instance.isLoggedIn {
      MessageService.instance.getAllChannels { success in
        guard success else { return }
        print(MessageService.instance.channels)
      }
    }
    else {
      channelNameLabel.text = "Please Log In"
    }
  }
  
  @objc func channelSelected() {
    updateWithChannel()
  }
  
  func updateWithChannel() {
    let channelName = MessageService.instance.selectedChannel?.name ?? "Smack"
    channelNameLabel.text = "#\(channelName)"
  }
  func getMessages() {
    MessageService.instance.getAllChannels { success in
      if success {
        print("Got messages")
        // TODO: do stuff
      }
    }
  }
}
