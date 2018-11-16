//
//  RoundedButton.swift
//  Smack
//
//  Created by Katherine Ebel on 11/15/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
  @IBInspectable var cornerRadius: CGFloat = 3.0 {
    didSet {
      layer.cornerRadius = cornerRadius
    }
  }
  
  override func awakeFromNib() {
    setupView()
  }
  
  func setupView() {
    layer.cornerRadius = cornerRadius
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupView()
  }
}
