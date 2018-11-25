//
//  ChannelViewController.swift
//  Smack
//
//  Created by Katherine Ebel on 11/14/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit


class ChannelViewController: UIViewController {
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var profileImageView: CircleImageView!
  @IBOutlet var tableView: UITableView!
  
  var avatar: Avatar!
  
  override func viewDidLoad() {
    self.revealViewController()?.leftViewRevealWidth = self.view.frame.width - 60
    NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange), name: SmackNotification.userDataDidChange.notificationName, object:  nil)
    NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded), name: SmackNotification.channelsLoaded.notificationName, object: nil)
//    SocketService.instance.getChannel { success in
//      guard success else { return }
//      self.tableView.reloadData()
//    }
  }
  
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    guard AuthService.instance.isLoggedIn else {
//      MessageService.instance.clearChannels()
//      return
//    }
//  }
  
  func setupView() {
    guard AuthService.instance.isLoggedIn else {
      loginButton.setTitle("Login", for: .normal)
      profileImageView.image = UIImage(named: UserDefaultKeys.avatarName.rawValue)
  
      profileImageView.backgroundColor = UIColor.clear
      return
    }
    guard let user = CurrentUserService.instance.user else { return }
    loginButton.setTitle(CurrentUserService.instance.user?.name, for: .normal)
    profileImageView.image = UIImage(named: user.avatar.imageName)
    profileImageView.backgroundColor = user.avatar.colorFromComponents()
  }
  
  @objc func userDataDidChange() {
    setupView()
    tableView.reloadData()
  }
  
  @objc func channelsLoaded() {
    self.tableView.reloadData()
  }

  @IBAction func loginButtonTapped(_ sender: UIButton) {
    guard AuthService.instance.isLoggedIn else {
      performSegue(withIdentifier: Identifier.toLogin.rawValue, sender: self)
      return
    }
    let profileVC = ProfileViewController()
    profileVC.modalPresentationStyle = .custom
    present(profileVC, animated: true, completion: nil)
  }
  
  @IBAction func unwindToChannel(_ sender: UIStoryboardSegue) {
    print("Unwind segue called")
  }
  
  @IBAction func addChannelTapped() {
    guard AuthService.instance.isLoggedIn else {
      let loginVC = LoginViewController()
      loginVC.modalPresentationStyle = .custom
      present(loginVC, animated: true, completion: nil)
      return
    }
    let addChannelVC = AddChannelViewController()
    addChannelVC.modalPresentationStyle = .custom
    present(addChannelVC, animated: true, completion: nil)
  }
}

extension ChannelViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let channel = MessageService.instance.channels[indexPath.row]
    MessageService.instance.selectedChannel = channel
    self.revealViewController()?.revealLeftView()
  }
}

extension ChannelViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MessageService.instance.channels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.channelCell.rawValue, for: indexPath) as? ChannelCell else {
      return ChannelCell()
    }
    cell.channel = MessageService.instance.channels[indexPath.row]
    return cell
  }
  
  
}
