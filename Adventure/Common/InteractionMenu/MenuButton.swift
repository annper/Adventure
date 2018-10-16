//
//  MenuButton.swift
//  Adventure
//
//  Created by Annie Persson on 16/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class MenuButton: UIButton {
    
  override func awakeFromNib() {
    
    // Set background colour if one is available
    if let bgColor = self.getParentViewBackgroundColor() {
      self.backgroundColor = bgColor
    }
    
    // Create border
    self.layer.cornerRadius = 3
    self.layer.borderColor = self.titleColor(for: .normal)?.cgColor
    self.layer.borderWidth = 1
    
    // Set shadow
    self.layer.shadowColor = Globals.Color.mainBackground.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    self.layer.shadowOpacity = 1
    self.layer.shadowRadius = 0.0
    self.layer.masksToBounds = false
    
    // Add padding wround text
    let padding: CGFloat = 12
    self.contentEdgeInsets = UIEdgeInsetsMake(padding, padding, padding, padding)
    
  }
  
}

private extension MenuButton {
  
  /// Get the backgroundColor of the view this button was added to
  private func getParentViewBackgroundColor() -> UIColor? {
    guard let buttonSuperview = self.superview, let parentView = buttonSuperview.superview else {
      return nil
    }
    
    return parentView.backgroundColor
  }
}

class MainMenuButton: MenuButton {
  
}
