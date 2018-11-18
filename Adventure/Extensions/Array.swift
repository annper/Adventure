//
//  Array.swift
//  Adventure
//
//  Created by Annie Persson on 16/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

extension Array where Element: Hashable {
  
  func removeDuplicates() -> [Element] {
    return self.reduce([]) { (result, element) -> [Element] in
      return result.contains(element) ? result : result + [element]
    }
  }
  
}
