//
//  InteractionMenuVC.swift
//  Adventure
//
//  Created by Annie Persson on 03/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

// TODO: - Create plugin VC for the interaction menu. Mmight require a xib
// This should include normal game interactions such as:
// - Interact (submenu for pull, push, talk etc)
// - Open inventory (new screen)
// - Move either direction (forward, back, left, right)
// - Inspect: Give info on surroundings

class InteractionMenuVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Logger.info("InteractionMenuVC")
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
