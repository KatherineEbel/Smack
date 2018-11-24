//
//  CircleImageView.swift
//  Smack
//
//  Created by Katherine Ebel on 11/16/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

@IBDesignable class CircleImageView: UIImageView {
  override func awakeFromNib() {
    setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()

  }
  
  func setupView() {
    layer.cornerRadius = frame.width / 2
//    clipsToBounds = true
  }
}
