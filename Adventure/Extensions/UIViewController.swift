//
//  UIViewController.swift
//  Adventure
//
//  Created by Annie Persson on 06/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

extension UIView {

  public func add(_ child: UIView) {

    self.addSubview(child)

    child.frame = self.frame
    child.center = self.center

  }

}

extension UIViewController {
  
  public func add(_ child: UIViewController) {
    
    self.addChildViewController(child)
    
    self.view.addSubview(child.view)
    
    child.didMove(toParentViewController: self)
    
  }
  
  public func remove() {
    
    guard parent != nil else {
      return
    }
    
    self.willMove(toParentViewController: nil)
    self.removeFromParentViewController()
    self.view.removeFromSuperview()
    
  }
  
  func add(_ child: UIViewController, to view: UIView) {
    child.willMove(toParentViewController: self)
    
    self.addChildViewController(child)
    view.addSubview(child.view)
    
    child.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      child.view.topAnchor.constraint(equalTo: view.topAnchor),
      child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      child.view.leftAnchor.constraint(equalTo: view.leftAnchor),
      child.view.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
    
    child.didMove(toParentViewController: self)
  }
  
}
