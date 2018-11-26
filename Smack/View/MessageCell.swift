//
//  MessageCell.swift
//  Smack
//
//  Created by Katherine Ebel on 11/26/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

  @IBOutlet var iconImageView: CircleImageView!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var messageLabel: UILabel!
  
  var message: Message? {
    didSet {
      guard let message = message else { return }
      iconImageView.image = UIImage(named: message.userAvatar)
      iconImageView.backgroundColor = CurrentUserService.instance.user?.avatar.colorFromComponents()
      userNameLabel.text = message.userName
//      timeLabel.text = message.timeStamp
      messageLabel.text = message.messageBody
    }
  }
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
