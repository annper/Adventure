//
//  InventoryView.swift
//  Adventure
//
//  Created by Annie Persson on 17/11/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

// MARK: - Delegates

protocol InventoryDelegate {
  func didExit()
}

// MARK: - Inventory VC

class InventoryVC: UIViewController {
  
  // MARK: - Private properties
    
  /// Background colour of the inventory. Defaults to blue
  private var bgColor: UIColor = UIColor.blue
  
  /// Text colour of inventory. Defaults to white
  private var textColor: UIColor = UIColor.white
  
  /// Font of the text in the inventory
  private var font: UIFont = UIFont(name: "Rockwell-Regular", size: 17)!
  
  // MKAR: - Init
  
  convenience init(bgColor: UIColor, textColor: UIColor, font: UIFont?) {
    self.init()
    self.bgColor = bgColor
    self.textColor = textColor
    self.font = font ?? self.font
  }
  
  // MARK: -  Delegate properties
  
  var delegate: InventoryDelegate? = nil
  
  // MARK: - IBOutlets
  @IBOutlet var exitButton: UIButton! { didSet {
    self.exitButton.setTitleColor(self.textColor, for: .normal)
  }}
  
  @IBOutlet var headerView: UIView! { didSet {
    self.headerView.backgroundColor = self.bgColor
  }}
  
  @IBOutlet var tableView: UITableView! { didSet {
    self.tableView.backgroundColor = self.bgColor
    self.tableView.tableFooterView = UIView()
    self.tableView.allowsSelection = false
    self.tableView.separatorStyle = .singleLine
    self.tableView.isScrollEnabled = true
    self.tableView.register(UINib.init(nibName: "InventoryCell", bundle: nil), forCellReuseIdentifier: InventoryCellItem.reuseIdentifier)
    self.tableView.dataSource = self.dataSource
  }}
  
  // MARK: - Table view setup
  
  private lazy var dataSource: TableViewDataSource<InventoryCellItem> = {
    let temp = TableViewDataSource(models: [InventoryCellItem(id: 1, image: nil, title: "test", status: "test")], reuseIdentifier: InventoryCellItem.reuseIdentifier, cellConfigurator: { (item, cell) in
      
      let displayCell = cell as! InventoryCell
      displayCell.titleLabel.text = item.title
      displayCell.statusLabel.text = item.status
      displayCell.imgView.image = item.image
      
    })
    
    return temp
  }()
  
  private lazy var tableDelegate: TableViewDelegate<InventoryCellItem> = {
    let temp = TableViewDelegate<InventoryCellItem>(selectedRow: { (item) in
      Logger.info("Tapped cell with id: \(item.id)")
    })
    
    temp.rowHeight = 60
    
    return temp
  }()
  
  // MARK: - IBActions
  
  /// Calls the delegate method for exiting
  @IBAction func didTapExitButton(_ sender: UIButton) {
    Logger.info("didTapExitButton")
    
    if let delegate = self.delegate {
      delegate.didExit()
    }
  }
  
}

// MARK: - InventoryVC access API

extension InventoryVC {
  
  func setAvailableItemCategories() {
    
  }
  
  func assignDefaultImageForCategory(image: UIImage?, category: String) {
    
  }
  
  
  
}

// MARK: - Inventory cell model

class InventoryCellItem: Model {
  
  static let reuseIdentifier = "InventoryCellItem"
  
  var id: Int
  var image: UIImage?
  var title: String
  var status: String
  
  init(id: Int, image: UIImage?, title: String, status: String) {
    self.id = id
    self.image = image
    self.title = title
    self.status = status
  }
}
