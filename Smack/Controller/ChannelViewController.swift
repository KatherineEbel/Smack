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
  override func viewDidLoad() {
    self.revealViewController()?.leftViewRevealWidth = self.view.frame.width - 60
    NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange), name: SmackNotification.userDataDidChange.notificationName, object:  nil)
  }
  
  @objc func userDataDidChange() {
    guard AuthService.instance.isLoggedIn else {
      loginButton.setTitle("Login", for: .normal)
      profileImageView.image = UIImage(named: "profileDefault")
      profileImageView.backgroundColor = UIColor.clear
      return
    }
    guard let user = CurrentUserService.instance.user else { return }
    loginButton.setTitle(CurrentUserService.instance.user?.name, for: .normal)
    profileImageView.image = UIImage(named: user.avatar.imageName)
    profileImageView.backgroundColor = user.avatar.colorFromComponents()
  }

  @IBAction func loginButtonTapped(_ sender: UIButton) {
    performSegue(withIdentifier: Identifier.toLogin.rawValue, sender: self)
  }
  
  @IBAction func unwindToChannel(_ sender: UIStoryboardSegue) {
    print("Unwind segue called@")
  }
}
