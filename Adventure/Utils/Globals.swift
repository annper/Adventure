//
//  Constants.swift
//  BoASCApp
//
//  Created by Annie Persson on 26/09/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation
import UIKit

public class Globals {
  
  static let shared = Globals()
  
}

// MARK: - Colour

extension Globals {
  
  public struct Color {
    
    /// #62FF1B
    static let mainText: UIColor = UIColor(red: 0.384, green: 1, blue: 0.107, alpha: 1)
   
    /// UIColor.darkGray (#545454)
    static let menuBackground: UIColor = UIColor.darkGray
    
    /// UIColor.black (#000000)
    static let mainBackground: UIColor = UIColor.blue
  }
  
}
