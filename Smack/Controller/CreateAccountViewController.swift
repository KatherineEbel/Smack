//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by Katherine Ebel on 11/14/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

  @IBOutlet var usernameTextField: UITextField!
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextfield: UITextField!
  @IBOutlet var avatarImageView: CircleImageView!
  @IBOutlet var chooseAvatarButton: UIButton!
  @IBOutlet var spinner: UIActivityIndicatorView!
  
  var avatar: Avatar? {
    didSet {
      guard let user = CurrentUserService.instance.user else {
        let newAvatar = avatar ?? Avatar(id: 0, type: .dark, color: nil)
        avatarImageView.image = UIImage(named: newAvatar.imageName)
        return
      }
      avatarImageView.image = UIImage(named: user.avatar.imageName)
    }
  }
  
  var bgColor: UIColor? {
    didSet {
      avatarImageView.backgroundColor = bgColor
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    let type = avatar?.type ?? .dark
    if type == .light && bgColor == nil {
      avatarImageView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    setupView()
  }
  
  
  func setupView() {
    usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: Theme.purple])
    passwordTextfield.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: Theme.purple])
    emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: Theme.purple])
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    view.addGestureRecognizer(tap)
  }
  
  @objc func handleTap() {
    view.endEditing(true)
  }
  @IBAction func chooseAvatarTapped(_ sender: UITapGestureRecognizer) {
    chooseAvatarButton.sendActions(for: .touchUpInside)
  }
  
  @IBAction func chooseAvatarTapped() {
    performSegue(withIdentifier: Identifier.toAvatarPicker.rawValue, sender: nil  )
  }
  @IBAction func generateBackgroundColorTapped() {
    let max: CGFloat = 255
    let range = ClosedRange(uncheckedBounds: (0, max))
    let r = CGFloat.random(in: range) / max
    let g = CGFloat.random(in: range) / max
    let b = CGFloat.random(in: range) / max
    UIView.animate(withDuration: 0.2) {
      self.bgColor = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
    }
  }
  @IBAction func createAccountTapped() {
    UIView.animate(withDuration: 0.5) {
      self.view.alpha = 0.4
    }
    spinner.startAnimating()
    guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextfield.text, !password.isEmpty, let name = self.usernameTextField.text, !name.isEmpty else { return }
    AuthService.instance.registerUser(email: email, password: password) { success in
      if success {
        AuthService.instance.loginUser(email: email, password: password, completion: { [weak self] success in
          if success {
            AuthService.instance.createUser(name: name, email: email, avatarName: UserDefaultKeys.avatarName.rawValue, avatarColor: UserDefaultKeys.avatarColor.rawValue, completion: { success in
              UIView.animate(withDuration: 0.5) {
                self?.view.alpha = 1.0
              }
              self?.spinner.stopAnimating()
              self?.performSegue(withIdentifier: Identifier.unwindFromCreateAccount.rawValue, sender: nil)
              NotificationCenter.default.post(name: SmackNotification.userDataDidChange.notificationName, object: nil)
            })
          }
        })
      } else {
        print("Ooops! something went wrong")
      }
    }
  }
}
