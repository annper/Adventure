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
    
    /// Neon green (#62FF1B)
    static let mainText: UIColor = UIColor(red: 0.384, green: 1, blue: 0.107, alpha: 1)
   
    /// UIColor.darkGray (#545454)
    static let menuBackground: UIColor = UIColor.darkGray
    
    /// UIColor.black (#000000)
    static let mainBackground: UIColor = UIColor.black
    
    /// Light blue (#5EC2FF)
    static let inventoryBlue: UIColor = UIColor(red: 0.369, green: 0.761, blue: 1.000, alpha: 1)
    
    /// Light green (#09C593)
    static let inventoryGreen: UIColor = UIColor(red: 0.035, green: 0.773, blue: 0.576, alpha: 1)
  }
  
}

// MARK: - Font

extension Globals {
  
  public struct Font {
    
    static func helveticaNeueRegular(size: CGFloat) -> UIFont {
      return UIFont(name: "HelveticaNeue-Regular", size: size)!
    }
    
    static func rockwellRegular(size: CGFloat) -> UIFont {
      return UIFont(name: "Rockwell", size: size)!
    }
    
  }
}
