//
//  TextDisplayView.swift
//  Adventure
//
//  Created by Annie Persson on 06/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

protocol TextDisplayDelegate {
  func didFinishDisplayingText(with item: TextCellItem)
}
/**
 * A scrolling view that can display text by typing it out one character at a time.
 * Added text is always added at the bottom of the view.
 * - Color and font can be set on individual text snippets.
 * - Add this VC to your view and call func display(_ text: String, finished: (() -> Void)? = nil) to start displaying text
 * - Optionally use the delegate TextDisplayDelegate to monitor when the last pice of text finished displaying
 */
class TextDisplayVC: UIViewController {
  
  @IBOutlet var tableView: UITableView! { didSet {
    tableView.backgroundColor = self.backgroundColor
    tableView.tableFooterView = UIView()
    tableView.allowsSelection = false
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 44
    tableView.separatorStyle = .none
    tableView.isScrollEnabled = true
    tableView.register(UINib.init(nibName: "TextDisplayCell", bundle: nil), forCellReuseIdentifier: TextCellItem.reuseIdentifier)
    self.tableView.dataSource = self.dataSource
    self.tableView.delegate = self.tableDelegate
  }}
  
  /// The TextDisplayViews background colour. Defaults to black
  private var backgroundColor: UIColor = UIColor.black
  
  /// The speed at which the text is written. Defaults to 0.5
  private var typePace: Double = 0.5
  
  /// The font to type the text in. Defaults to Helvetica-Thin, size 14
  private var font: UIFont = UIFont(name: "HelveticaNeue-Thin", size: 14)!
  
  /// The text colour to use. Defaults to white
  private var textColor: UIColor = UIColor.white
  
  private var models: [TextCellItem] {
    return dataSource.models
  }
  private var delegate: TextDisplayDelegate?
  
  /// The id of the last TextCellItem ti be added. Starts at 1
  private var lastId: Int = 0
  
  /// Indicates whether a typing animation is currently in progress
  private var isTyping: Bool = false
  
  convenience init(typePace: Double, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
    self.init()
    self.typePace = typePace
    self.font = font
    self.textColor = textColor
    self.backgroundColor = backgroundColor
  }
  
  private lazy var dataSource: TableViewDataSource<TextCellItem> = {
    let temp = TableViewDataSource(models: [TextCellItem](), reuseIdentifier: TextCellItem.reuseIdentifier, cellConfigurator: { (item, cell) in
      
      let displayCell = cell as! TextDisplayCell
      displayCell.label.isHidden = self.models.count == item.id // Hide the text in the last added cell
      displayCell.label.text = item.text
      displayCell.label.font = item.font
      displayCell.label.textColor = item.textColor
      
    })
    
    return temp
  }()
  
  private lazy var tableDelegate: TableViewDelegate<TextCellItem> = {
    let temp = TableViewDelegate<TextCellItem>(selectedRow: { (item) in
      Logger.info("Tapped cell with id: \(item.id)")
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
    // Test text, should be removed
    let text = "This is a superlong text with lots to say and also some line breaks\n\n\nThere that was a broken\nline and then some dots .......\n...\n......"
    
    // Only display the next item if the last one has finished being added
    if self.isTyping || text.isEmpty { return }
    self.isTyping = true

    // Add the new row and scroll to the bottom so its visible
    let addedItem = self.addRowWith(text: text)
    self.scrollToBottom()
    
    // Postpone typing out the text until the scroll to bottom aimation has finished
    // Theres probably a better way of doing this, but this was the most straight forward
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      let bottomCell = self.tableView.visibleCells.last as? TextDisplayCell
      
      // Retrieve the cell we just added to perform the text animation on it
      guard let newlyAddedCell = bottomCell /*self.bottomCell()*/ else {
        self.isTyping = false
        return
      }
      
      // Animate displaying the text
      newlyAddedCell.display(text: text, atPace: self.typePace) {
        self.isTyping = false
        
        if let finished = finished {
          finished()
        }
        
        if let delegate = self.delegate {
          delegate.didFinishDisplayingText(with: addedItem)
        }
      }
    }
    
  }
  
}

// MARK: - Private methods

private extension TextDisplayVC {
  
  func addRowWith(text: String) -> TextCellItem {
    self.lastId += 1
    let newItem = TextCellItem(id: self.lastId, text: text, font: self.font, textColor: self.textColor)
    dataSource.models.append(newItem)
    tableView.reloadData()
    return newItem
  }
  
  /// Scroll to the bottom of the TextDisplayView
  func scrollToBottom() {
    let bottomRowIndex = dataSource.models.count - 1
    let indexPath = IndexPath(row: bottomRowIndex, section: 0)
    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
  }
  
}

// MARK: - TextCellItem

class TextCellItem: Model {
  
  static let reuseIdentifier = "TextCellItem"
  
  var id: Int
  var text: String
  var font: UIFont
  var textColor: UIColor
  
  init(id: Int, text: String, font: UIFont, textColor: UIColor) {
    self.id = id
    self.text = text
    self.font = font
    self.textColor = textColor
  }
  
}
