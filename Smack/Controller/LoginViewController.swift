//
//  LoginViewController.swift
//  Smack
//
//  Created by Katherine Ebel on 11/14/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var spinner: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView() {
    emailTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor: Theme.purple])
    passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: Theme.purple])
  }
  
  @IBAction func logginTapped() {
    guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
    spinner.startAnimating()
    view.alpha = 0.5
    AuthService.instance.loginUser(email: email, password: password) { success in
      guard success else { return }
      AuthService.instance.findUserByEmail(completion: { [weak self] success in
        self?.spinner.stopAnimating()
        self?.view.alpha = 1.0
        guard success else { return }
        NotificationCenter.default.post(name: SmackNotification.userDataDidChange.notificationName, object: nil)
        self?.dismiss(animated: true, completion: nil)
      })
    }
  }
  @IBAction func closeButtonTapped() {
    dismiss(animated: true, completion: nil)
  }
}
