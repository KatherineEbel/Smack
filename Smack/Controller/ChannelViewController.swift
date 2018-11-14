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
  override func viewDidLoad() {
    self.revealViewController()?.leftViewRevealWidth = self.view.frame.width - 60
  }
  
  
  // MARK: - Navigation
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == Identifier.toLogin.rawValue {
//      
//    }
//  }
  @IBAction func loginButtonTapped(_ sender: UIButton) {
    performSegue(withIdentifier: Identifier.toLogin.rawValue, sender: self)
  }
  
  @IBAction func unwindFromLogin(_ sender: UIStoryboardSegue) {
    
  }
}
