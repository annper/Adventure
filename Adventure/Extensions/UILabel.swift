//
//  UILabel.swift
//  Adventure
//
//  Created by Annie Persson on 17/11/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

extension UILabel {
  
  /// UILabel font will scale down when the text doesnt fit with the default font size
  /// - parameter to: The minimum scale factor that the text size should scale to
  public func setMinimumFontScale(to scaleFactor: CGFloat) {
    self.allowsDefaultTighteningForTruncation = true
    self.lineBreakMode = .byClipping
    self.adjustsFontSizeToFitWidth = true
    self.minimumScaleFactor = scaleFactor
    self.numberOfLines = 1
  }
  
}


