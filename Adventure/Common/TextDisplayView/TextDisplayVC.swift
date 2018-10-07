//
//  TextDisplayView.swift
//  Adventure
//
//  Created by Annie Persson on 06/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

/*
 * - Display text at a set pace
 * - Display text of certain colour
 * - Add text at bottom of view
 * - Scroll view down as new text is added
 * - Add text of different font
 */
class TextDisplayVC: UIViewController {
  
  private var tableView: UITableView!
  
  private lazy var factory = TextDisplayFactory(backgroundColor: self.backgroundColor)
  
  private var backgroundColor: UIColor = UIColor.black
  private var typePace: Double = 0.5
  private var font: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 14)!
  private var textColor: UIColor = UIColor.white
  
  private var lastId: Int = 0
  private var isTyping: Bool = false
  
  convenience init(typePace: Double, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
    self.init()
    self.typePace = typePace
    self.font = font
    self.textColor = textColor
    self.backgroundColor = backgroundColor
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView = factory.createTableView()
    self.tableView.dataSource = self.dataSource
    self.tableView.delegate = self.tableDelegate
    
    self.view.addSubview(tableView)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    tableView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
  }
  
  private lazy var dataSource: TableViewDataSource<TextCellItem> = {
    let temp = TableViewDataSource(models: [TextCellItem](), reuseIdentifier: TextCellItem.reuseIdentifier, cellConfigurator: { (item, cell) in
      
      let displayCell = cell as! TextDisplayCell
      displayCell.label.text = item.text
      displayCell.label.font = self.font
      displayCell.label.textColor = self.textColor
      
    })
    
    return temp
  }()
  
  private lazy var tableDelegate: TableViewDelegate<TextCellItem> = {
    let temp = TableViewDelegate<TextCellItem>(selectedRow: { (item) in
      Logger.info("Tapped cell with text: \(item.text)")
    })
    
    return temp
  }()
  
}

// MARK: - Public methods

extension TextDisplayVC {
  
  /// Set the speed of which new text should be typed out
  func setTypePace(to pace: Double) {
    self.typePace = pace
  }
  
  /// Set the font to use for displayed text
  func setFont(to font: UIFont) {
    self.font = font
  }
  
  /// Set the colour of the display text
  func setTextColor(to color: UIColor) {
    self.textColor = color
  }
  
  /// Set the colour of the background view
  func setBackgroundColor(to color: UIColor) {
    self.backgroundColor = color
    self.tableView.backgroundColor = color
  }
  
  /// Display the text at the bottom of the screen by printing it out one character at a time
  /// - parameter text: The full text to display
  /// - parameter finished: If supplied, this is called once the text has finished being printed in full
  public func display(_ text: String, finished: (() -> Void)? = nil) {
    Logger.info("Attempt to dispaly text: \(text)")
    var text = "This is a superlong text with lots to say and also some line breaks\n\n\nThere that was a broken\nline and then some dots .......\n...\n......"
    
    // Only dispaly the next item if the last one has finished being added
    if self.isTyping || text.isEmpty { return }
    self.isTyping = true

    // Add the new row and scroll to the bottom so its visible
    self.addRowWith(text: text)
    self.scrollToBottom()
    
    // Retrieve the cell we just added to perform the text animation on it
    guard let newlyAddedCell = self.bottomCell() else {
      self.isTyping = false
      return
    }
    
    // Animate displaying the text
    newlyAddedCell.display(text: text, atPace: self.typePace) {
      self.isTyping = false
      
      if let finished = finished {
        finished()
      }
    }
    
  }
  
}

// MARK: - Private methods

private extension TextDisplayVC {
  
  func addRowWith(text: String) {
    self.lastId += 1
    dataSource.models.append(TextCellItem(text, id: self.lastId))
    tableView.reloadData()
  }
  
  func scrollToBottom() {
    let bottomRowIndex = dataSource.models.count - 1
    let indexPath = IndexPath(row: bottomRowIndex, section: 0)
    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
  }
  
  func bottomCell() -> TextDisplayCell? {
    let bottomRowIndex = dataSource.models.count - 1
    let indexPath = IndexPath(row: bottomRowIndex, section: 0)
    return self.tableView.cellForRow(at: indexPath) as? TextDisplayCell
  }
  
//  func configure(_ cell: TextDisplayCell, withItem item: TextCellItem) -> TextDisplayCell {
//    cell.label.text = item.text
//    cell.label.font = self.font
//    cell.label.textColor = self.textColor
//    return cell
//  }
  
}

// MARK: - TextCellItem

class TextCellItem: Model {
  
  static let reuseIdentifier = "TextCellItem"
  
  var text: String
  var id: Int
  
  init(_ text: String, id: Int) {
    self.text = text
    self.id = id
  }
  
}

// MARK: - TextDisplayFactory

class TextDisplayFactory {
  
  private let backgroundColor: UIColor!
  
  init(backgroundColor: UIColor) {
    self.backgroundColor = backgroundColor
  }
  
  func createTableView() -> UITableView {
    let tableView = UITableView()
    
    tableView.backgroundColor = self.backgroundColor
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 44
    tableView.separatorStyle = .none
    tableView.isScrollEnabled = true
    tableView.register(UINib.init(nibName: "TextDisplayCell", bundle: nil), forCellReuseIdentifier: TextCellItem.reuseIdentifier)
    
    return tableView
  }
  
}
