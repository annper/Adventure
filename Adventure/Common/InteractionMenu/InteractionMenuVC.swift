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
  func didCloseInventory()
}

protocol InteractionMenuActionDelegate {
  func didTalk()
  func didPush()
  func didPull()
  func didInspect()
  func didPickUp()
}

/// How tp make a protocol method optional
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
      self.moveButton
      // Add any new buttons here...
    ]
  }()
  
  // MARK: - IBOutlets
  
  @IBOutlet var containerView: UIView!
  
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
  }
  
  @IBAction func didTapInventoryButton(_ sender: MenuButton) {
    Logger.info("didTapInventoryButton")
    
    // TODO: - Close inventory, notify delegate, add smooth animation between state
    self.hideMainMenuButtons()
    self.inventoryButton.isHidden = false
    
    self.setInventoryTitle(to: "X Close")
    
    if let delegate = inventoryDelegate {
      delegate.didOpenInventory()
    }
  }
  
  @IBAction func didTapMoveButton(_ sender: MenuButton) {
    Logger.info("didTapMoveButton")
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

// MARK: - Remove/Add main menu buttons

extension InteractionMenuVC {
  
  /// Remove one of the main manu buttons from the menu
  func removeMainMenuOption(_ option: MainMenuOption) {
    var button: UIButton
    
    switch option {
    case .interact:
      button = self.interactButton
    case .inventory:
      button = self.inventoryButton
    case .move:
      button = self.moveButton
    }
    
    self.mainMenuStackView.removeArrangedSubview(button)
    button.removeFromSuperview()
    
    self.mainMenuStackView.distribution = .fillEqually
    self.mainMenuStackView.spacing = 15
  }
  
  /// Add one of the main menu options to the menu. If adding back a button thats already there it will simply be ignored. This method can also be used as a way to rearrange the orde rin which the options appear on the menu.
  /// - parameter option: The menu option to add
  /// - parameter atIndex: Provide this if you want to rearrange the buttons. The default order is: Interact, Inventory, Move
  func addMainMenuOption(_ option: MainMenuOption, atIndex index: Int? = nil) {
    var button: UIButton
    
    switch option {
    case .interact:
      button = self.interactButton
    case .inventory:
      button = self.inventoryButton
    case .move:
      button = self.moveButton
    }
    
    let stackViewIndex = index ?? option.rawValue
    self.mainMenuStackView.insertArrangedSubview(button, at: stackViewIndex)
    
    if self.mainMenuStackView.arrangedSubviews.count >= 3 {
      self.mainMenuStackView.distribution = .equalSpacing
      self.mainMenuStackView.spacing = 0
    }
  }
  
  enum MainMenuOption: Int {
    case interact = 0
    case inventory
    case move
  }
  
}

/// MARK: - Private methods

internal extension InteractionMenuVC {
  
  func hideMainMenuButtons() {
    self.allButtons.forEach { (button) in
      
      if let mainMenuButton = button as? MainMenuButton {
        mainMenuButton.isHidden = true
      }
    }
  }
}
