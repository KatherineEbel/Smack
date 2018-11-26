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
  @IBOutlet var messageTextField: UITextField!
  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    view.bindToKeyboard()
    tableView.estimatedRowHeight = 80
    tableView.rowHeight = UITableView.automaticDimension
    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTap))
    view.addGestureRecognizer(tap)
    menuButton.addTarget(self.revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchUpInside)
    addObservers()
    guard AuthService.instance.isLoggedIn else { return }
    AuthService.instance.findUserByEmail { success in
      guard success else { return }
      NotificationCenter.default.post(name: SmackNotification.userDataDidChange.notificationName, object: nil)
    }
  }
  
  @objc func dismissKeyboardTap() {
    view.endEditing(true)
  }
  
  @objc func userDataChanged() {
    if AuthService.instance.isLoggedIn {
      getMessages()
    }
    else {
      channelNameLabel.text = "Please Log In"
    }
  }
  
  @objc func channelSelected() {
    updateWithChannel()
  }
  
  func addObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged), name: SmackNotification.userDataDidChange.notificationName, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(channelSelected), name: SmackNotification.channelSelected.notificationName, object: nil)
  }
  
  func updateWithChannel() {
    let channelName = MessageService.instance.selectedChannel?.name ?? "Smack"
    channelNameLabel.text = "#\(channelName)"
    getSelectedChannelMessages()
  }
  
  func getMessages() {
    MessageService.instance.getAllChannels { success in
      if success {
        let channels = MessageService.instance.channels
        guard !channels.isEmpty else {
          self.channelNameLabel.text = "No channels yet!"
          return
        }
        MessageService.instance.selectedChannel = channels[0]
        self.updateWithChannel()
      }
    }
  }
  
  func getSelectedChannelMessages() {
    guard let channelId = MessageService.instance.selectedChannel?._id else { return }
    MessageService.instance.messagesForChannel(channelId: channelId) { [weak self] success in
      self?.tableView.reloadData()
      print(MessageService.instance.messages)
    }
  }
  @IBAction func sendMessagePressed() {
    guard AuthService.instance.isLoggedIn else { return }
    guard let channelId = MessageService.instance.selectedChannel?._id else { return }
    guard let message = messageTextField.text, !message.isEmpty else { return }
    guard let user = CurrentUserService.instance.user else { return }
    SocketService.instance.addMessage(body: message, userId: user.id, channelId: channelId) { [weak self] success in
      self?.messageTextField.text = ""
      self?.messageTextField.resignFirstResponder()
    }
  }
}

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MessageService.instance.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let messages = MessageService.instance.messages
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.messageCell.rawValue, for: indexPath) as? MessageCell else { return MessageCell() }
    cell.message = messages[indexPath.row]
    return cell
  }
  
  
}
