//
//  InventoryCell.swift
//  Adventure
//
//  Created by Annie Persson on 17/11/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class InventoryCell: UITableViewCell {
  
  
  @IBOutlet var imgView: UIImageView!
  
  @IBOutlet var titleLabel: UILabel! { didSet {
    // Shrink the location font size to make sure the full text is visible over one line
    self.titleLabel.setMinimumFontScale(to: 0.10)
  }}
  
  @IBOutlet var statusLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
