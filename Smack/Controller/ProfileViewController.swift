//
//  ProfileViewController.swift
//  Smack
//
//  Created by Katherine Ebel on 11/17/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  @IBOutlet var profileImageView: CircleImageView!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var userEmailLabel: UILabel!
  @IBOutlet var bgView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let user = CurrentUserService.instance.user else {
      fatalError("No logged in user!")
    }
    profileImageView.image = UIImage(named: user.avatar.imageName)
    profileImageView.backgroundColor = user.avatar.colorFromComponents()
    userNameLabel.text = user.name
    userEmailLabel.text = user.email
    let tap = UITapGestureRecognizer(target: self, action: #selector(closeModal))
    bgView.addGestureRecognizer(tap)
  }
  
  @objc func closeModal() {
    dismiss(animated: true, completion: nil)
  }
  @IBAction func closeModalTapped() {
    closeModal()
  }
  @IBAction func logOutTapped() {
    CurrentUserService.instance.logout()
    dismiss(animated: true, completion: nil)
  }
}
