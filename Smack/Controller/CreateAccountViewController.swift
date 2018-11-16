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
  @IBOutlet var avatarImageView: UIImageView!
  @IBOutlet var chooseAvatarButton: UIButton!
  @IBAction func chooseAvatarTapped(_ sender: UITapGestureRecognizer) {
    // TODO: choose Avatar code
    print("Choose Avatar image tapped!")
    chooseAvatarButton.sendActions(for: .touchUpInside)
  }
  
  @IBAction func chooseAvatarTapped() {
    print("Choose Avatar button tapped!")
  }
  @IBAction func generateBackgroundColorTapped() {
  }
  @IBAction func createAccountTapped() {
    guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextfield.text, !password.isEmpty else { return }
    AuthService.instance.registerUser(email: email, password: password) { success in
      if success {
        AuthService.instance.loginUser(email: email, password: password, completion: { success in
          if success {
            print("Logged in user", AuthService.instance.authToken)
          }
        })
      } else {
        print("Ooops! something went wrong")
      }
    }
  }
}
