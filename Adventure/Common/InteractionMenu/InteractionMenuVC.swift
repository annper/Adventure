//
//  InteractionMenuVC.swift
//  Adventure
//
//  Created by Annie Persson on 03/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

// MARK: - Delegates for the different interactions

protocol InteractionMenuDirectionsDelegate {
  func didMoveForward()
  func didMoveBackward()
  func didMoveLeft()
  func didMoveRight()
}

protocol InteractionMenuInventoryDelegate {
  func didOpenInventory()
}

protocol InteractionMenuActionDelegate {
  func didTalk()
  func didPush()
  func didPull()
  func didInspect()
  func didPickUp()
}

/// How to make a protocol method optional
extension InteractionMenuActionDelegate {
  func didPush() {}
}

// TODO: - Create plugin VC for the interaction menu. Might require a xib
// This should include normal game interactions such as:
// - Interact (submenu for pull, push, talk etc)
// - Open inventory (new screen)
// - Move either direction (forward, back, left, right)
// - Inspect: Give info on surroundings

class InteractionMenuVC: UIViewController {
  
  private var bgColor: UIColor = UIColor.gray
  
  convenience init(bgColor: UIColor) {
    self.init()
    self.bgColor = bgColor
  }
  
  // MARK: - Public properties
  
  public var inventoryDelegate: InteractionMenuInventoryDelegate?
  public var actionDelegate: InteractionMenuActionDelegate?
  public var directionsDelegate: InteractionMenuDirectionsDelegate?
  
  // MARK: - Private properties
  
  /// Holds all buttons in the menu so to easily apply changes to all at the same time
  private lazy var allButtons: [MenuButton] = {
    return [
      self.interactButton,
      self.inventoryButton,
      self.moveButton,
      // Add any new buttons here...
    ]
  }()
  
  // MARK: - IBOutlets
  
  @IBOutlet var containerView: UIView! { didSet {
    self.containerView.backgroundColor = self.bgColor
  }}
  
  @IBOutlet var mainMenuStackView: UIStackView! { didSet {
    self.mainMenuStackView.distribution = .equalSpacing
    self.mainMenuStackView.spacing = 0
  }}
  
  @IBOutlet var interactButton: MainMenuButton! { didSet {
    self.interactButton.backgroundColor = self.containerView.backgroundColor
  }}
  
  @IBOutlet var inventoryButton: MainMenuButton! { didSet {
    self.inventoryButton.backgroundColor = self.containerView.backgroundColor
  }}
  
  @IBOutlet var moveButton: MainMenuButton! { didSet {
    self.moveButton.backgroundColor = self.containerView.backgroundColor
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapInteractButton(_ sender: MenuButton) {
    Logger.info("didTapInteractButton")
    
    // Opens the interaction menu
    // - Talk, pull, push etc
  }
  
  @IBAction func didTapInventoryButton(_ sender: MenuButton) {
    Logger.info("didTapInventoryButton")
    
    // This opens a view that slides in from the bottom
    // The GUI should be a list view of items. close button top right
    // ------------------------ X
    // id | img | title | status
    // id | img | title | status
    // -------------------------
    // Tap on an item to see details or equip
    
    if let delegate = self.inventoryDelegate {
      delegate.didOpenInventory()
    }
  }
  
  @IBAction func didTapMoveButton(_ sender: MenuButton) {
    Logger.info("didTapMoveButton")
    
    // Update options for possible moves
    // Forward, up down, back
    // Not all options need to be present at once
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Logger.info("InteractionMenuVC")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    Logger.warn("didReceiveMemoryWarning")
  }
  
}

// MARK: - Properties API

extension InteractionMenuVC {
  
  /// Set the background colour of the menu.
  /// Also changes the background colour of the buttons
  func setBackgroundColor(to color: UIColor) {
    self.containerView.backgroundColor = color
    
    self.allButtons.forEach { (button) in
      button.backgroundColor = color
    }
  }
  
  /// Set the text and border colour for all the buttons
  func setButtonTintColor(to color: UIColor) {
    self.allButtons.forEach { (button) in
      button.setTitleColor(color, for: .normal)
      button.layer.borderColor = color.cgColor
    }
  }
  
  // Set the font on all hte buttons
  func setFont(to font: UIFont) {
    self.allButtons.forEach { (button) in
      button.titleLabel?.font = font
    }
  }
  
  func setInventoryTitle(to title: String) {
    self.inventoryButton.setTitle(title, for: .normal)
  }
  
  func setMoveTitle(to title: String) {
    self.moveButton.setTitle(title, for: .normal)
  }
  
  func setInteractTitle(to title: String) {
    self.interactButton.setTitle(title, for: .normal)
  }

}

// MARK: - API to manage main menu button state

extension InteractionMenuVC {
  
  /// Disable on of the main menu buttons
  func disable(_ option: MainMenuOption) {
    
    let buttons = self.getMainMenuButtons(for: option)
    buttons.forEach { (button) in
      button.disable()
    }
  }
  
  /// Enable one of the main menu buttons
  func enable(_ option: MainMenuOption) {
    let buttons = self.getMainMenuButtons(for: option)
    buttons.forEach { (button) in
      button.enable()
    }
  }
  
//  func enable(_ [])
}

// MARK: - Remove/Add main menu buttons

extension InteractionMenuVC {
  
  /// Remove one of the main manu buttons from the menu
  func removeMainMenuOption(_ option: MainMenuOption) {
    let buttons = self.getMainMenuButtons(for: option)
    
    buttons.forEach { (button) in
      self.mainMenuStackView.removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    
    self.mainMenuStackView.distribution = .fillEqually
    self.mainMenuStackView.spacing = 15
  }
  
  /// Add one of the main menu options to the menu. If adding back a button thats already there it will simply be ignored. This method can also be used as a way to rearrange the order in which the options appear on the menu.
  /// - parameter option: The menu option to add
  /// - parameter atIndex: Provide this if you want to rearrange the buttons. The default order is: Interact, Inventory, Move
  func addMainMenuOption(_ option: MainMenuOption, atIndex index: Int? = nil) {
    let buttons = self.getMainMenuButtons(for: option)
    
    var stackViewIndex = index ?? option.rawValue
    
    buttons.forEach { (button) in
      self.mainMenuStackView.insertArrangedSubview(button, at: stackViewIndex)
      stackViewIndex += 1
    }
    
    if self.mainMenuStackView.arrangedSubviews.count >= 3 {
      self.mainMenuStackView.distribution = .equalSpacing
      self.mainMenuStackView.spacing = 0
    }
  }
  
  enum MainMenuOption: Int {
    case interact = 0
    case inventory
    case move
    case all
  }
  
}

/// MARK: - Private methods

internal extension InteractionMenuVC {
  
  /// Hide all the main buttons on the main menu
  /// Note that this won't show the close button. That will need to be done separately
  private func hideMainMenuButtons() {
    self.allButtons.forEach { (button) in
      
      if let mainMenuButton = button as? MainMenuButton {
        mainMenuButton.isHidden = true
      }
    }
  }
  
  /// Show all the main buttons on the main menu. This also hides the close button
  private func showMainMenuButtons() {
    self.allButtons.forEach { (button) in
      if let mainMenuButton = button as? MainMenuButton {
        mainMenuButton.isHidden = false
      }
    }
  }
  
  /// Return the MainMenuButton corresponding to the menu option
  /// - parameter option: The MainMenuOption for the button to be returned
  /// - returns: A MainMenuButton
  private func getMainMenuButtons(for option: MainMenuOption) -> [MainMenuButton] {
    switch option {
    case .interact:
      return [self.interactButton]
    case .inventory:
      return [self.inventoryButton]
    case .move:
      return [self.moveButton]
    case .all:
      return [self.interactButton, self.inventoryButton, self.moveButton]
    }
  }
  
}
