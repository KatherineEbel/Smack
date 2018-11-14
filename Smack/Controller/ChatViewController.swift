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
  
  override func viewDidLoad() {
    menuButton.addTarget(self.revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchUpInside)
  }
}
