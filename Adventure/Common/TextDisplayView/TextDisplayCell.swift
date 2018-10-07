//
//  TextDisplayCell.swift
//  Adventure
//
//  Created by Annie Persson on 06/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class TextDisplayCell: UITableViewCell {
  
  
  
  
  @IBOutlet var label: UILabel!
  
  /// Display the text on the label by typing out one character at a time
  /// - parameter text: The full text to dispay
  /// - parameter atPace: The rate at which characters are shown (in secionds)
  /// - parameter onCompletion: Function called once the full text has been shown
  func display(text: String, atPace pace: TimeInterval, onCompletion: (() -> Void)?) {
    
    // Start by emptying the text label and unhide it
    self.label.text = ""
    self.label.isHidden = false
    
    // Add one character at a time
    let textArray = Array(text)
    var i = 0
    Timer.scheduledTimer(withTimeInterval: pace, repeats: true) { (timer) in
      self.label.text?.append(textArray[i])
      
      i += 1
      if i == textArray.count {
        timer.invalidate()
        
        if let onCompletion = onCompletion {
          onCompletion()
        }
        
      }
    }
  }
  
}
