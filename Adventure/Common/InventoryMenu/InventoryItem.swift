//
//  InventoryItem.swift
//  Adventure
//
//  Created by Annie Persson on 18/11/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import Foundation

// All public methods should go here
protocol InventoryItemInterface {
  func setCategory(to category: InventoryCategory)
  func getCategoryName() -> String
  func getDescription() -> String
  func setName(to name: String)
}

// Class to hold info about an inventory item, such as category, name, desc and if its equipped

class InventoryItem: NSObject {
  
  // MARK: - Private properties
  
  private var category: InventoryCategory
  private var name: String
  private var desc: String
  
  // MARK: - Public properties
  
  var isEquipped: Bool = false
  
  // MARK: - Initialiser
  
  init(category: InventoryCategory, name: String, desc: String) {
    self.category = category
    self.name = name
    self.desc = desc
    super.init()
  }
  
}

// MARK - InventoryItemInterface implementation
extension InventoryItem: InventoryItemInterface {
  
  func setCategory(to category: InventoryCategory) {
    self.category = category
  }
  
  func getCategoryName() -> String {
    return self.category.name
  }
  
  func getDescription() -> String {
    return self.desc
  }
  
  func getName() -> String {
    return self.name
  }
  
  func setName(to name: String) {
    self.name = name
  }
  
}

// MARK - InventoryCategory

struct InventoryCategory {
  var name: String
}
