//
//  GameVC.swift
//  Adventure
//
//  Created by Annie Persson on 03/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

// TOOD: - Add shadow at top of screen so text will appear to fade out.
// - Create class for progressively showing text, and scroll with the text.
// - Add the interaction menu
// - Add a nice way to show/hide the interaction menu
// - Add small cogwheel in top left corner for open/hide sidemenu
// - Side menu is for: Saving/exiting/change colour/change language/reload etc

class GameVC: UIViewController {
  
  // MARK: - Private properties
  
  private let screenHeight: CGFloat = UIScreen.main.bounds.height
  
  // MARK: - IBOutlets
  
  @IBOutlet var storyContainerView: UIView!
  
  @IBOutlet var inventoryContainerView: UIView!
  
  @IBOutlet var inventoryContainerViewTopConstraint: NSLayoutConstraint! { didSet {
    self.inventoryContainerViewTopConstraint.constant = screenHeight
  }}
  
  @IBOutlet var menuContainerView: UIView!
  
  // Test stuff, currently unused
  @IBOutlet var testtextField: UITextField!
  private lazy var textDisplayVC: TextDisplayVC = {
    let temp = TextDisplayVC(typePace: 0.01, font: UIFont(name: "HelveticaNeue-Thin", size: 14)!, textColor: Globals.Color.mainText, backgroundColor: Globals.Color.mainBackground)
    
    return temp
  }()
  
  // MARK: - Initialise plugin VCs
  
  private lazy var interactionMenuVC: InteractionMenuVC = {
    let temp = InteractionMenuVC(bgColor: Globals.Color.menuBackground)
    
    temp.inventoryDelegate = self
    
    return temp
  }()
  
  private lazy var inventoryMenu: InventoryVC = {
    let temp = InventoryVC(bgColor: Globals.Color.inventoryGreen, textColor: UIColor.white, font: nil)
    
    temp.delegate = self
    
    return temp
  }()
  
  // MARK: - IBActions
  
  @IBAction func didTapTestButton(_ sender: Any) {
    Logger.info("didTapTestButton")
    
    let text = testtextField.text ?? ""
    textDisplayVC.display(text)
    
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Logger.info("GameVC")
    add(textDisplayVC, to: storyContainerView)
    add(inventoryMenu, to: inventoryContainerView)
    add(interactionMenuVC, to: menuContainerView)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    Logger.warn("didReceiveMemoryWarning")
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

// MARK: - InteractionMenu InventoryDelegate

extension GameVC: InteractionMenuInventoryDelegate {
  
  func didOpenInventory() {
    self.animateOpenInventory(withDuration: 0.3) {
      self.interactionMenuVC.disable(.all)
    }
//    self.interactionMenuVC.disable(.all)
//    self.interactionMenuVC.disable(.inventory)
  }
  
  private func animateOpenInventory(withDuration delay: TimeInterval, onComplete: (() -> Void)? = nil) {
    
    self.inventoryContainerViewTopConstraint.constant = 0
    
    UIView.animate(withDuration: delay, animations: {
      self.view.layoutIfNeeded()
    }) { (_) in
      if let complete = onComplete {
        complete()
      }
    }
    
  }
  
}

extension GameVC: InventoryDelegate {
  
  func didExit() {
    self.animateExitInventory(withDuration: 0.3) {
      self.interactionMenuVC.enable(.all)
    }
  }
  
  private func animateExitInventory(withDuration delay: TimeInterval, onComplete: (() -> Void)? = nil) {
    self.inventoryContainerViewTopConstraint.constant = self.screenHeight
    
    
    UIView.animate(withDuration: delay, animations: {
      self.view.layoutIfNeeded()
    }) { (_) in
      if let complete = onComplete {
        complete()
      }
    }
  }
}
