//
//  AvatarCell.swift
//  Smack
//
//  Created by Katherine Ebel on 11/16/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit



class AvatarCell: UICollectionViewCell {
    
  @IBOutlet var avatarImageView: UIImageView!
  var avatar: Avatar? {
    didSet {
      guard let avatarImageView = avatarImageView, let avatar = avatar else {
        return
      }
      avatarImageView.image = UIImage(named: avatar.imageName)
      layer.backgroundColor = avatar.type == .dark ? #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
      
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = 10
    layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    clipsToBounds = true
  }
}
