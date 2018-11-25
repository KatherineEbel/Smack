//
//  ChannelCell.swift
//  Smack
//
//  Created by Katherine Ebel on 11/24/18.
//  Copyright © 2018 Katherine Ebel. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

  @IBOutlet var nameLabel: UILabel!
  var channel: Channel? {
    didSet {
      nameLabel.text = "#\(channel?.name ?? "")"
    }
  }
  override func awakeFromNib() {
        super.awakeFromNib()  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      if selected {
        self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
      } else {
        self.layer.backgroundColor = UIColor.clear.cgColor
      }
    }

}
