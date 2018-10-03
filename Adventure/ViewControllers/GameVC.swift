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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Logger.info("GameVC")
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
