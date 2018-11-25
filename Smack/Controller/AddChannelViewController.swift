//
//  AddChannelViewController.swift
//  Smack
//
//  Created by Katherine Ebel on 11/24/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

  @IBOutlet var channelNameTextField: UITextField!
  @IBOutlet var channelDescriptionTextField: UITextField!
  @IBOutlet var bgView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  func setupView() {
    channelNameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor: Theme.purple])
    channelDescriptionTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor: Theme.purple])
    let tap = UITapGestureRecognizer(target: self, action: #selector(closeModal))
    bgView.addGestureRecognizer(tap)
  }
  
  @objc func closeModal() {
      dismiss(animated: true, completion: nil)
  }
  
  @IBAction func closeModalTapped() {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addChannelTapped() {
    guard let name = channelNameTextField.text, !name.isEmpty, let description = channelDescriptionTextField.text, !description.isEmpty else { return }
    SocketService.instance.addChannel(name: name, description: description) { [weak self] success in
      self?.dismiss(animated: true, completion: nil)
    }
  }
  
}
