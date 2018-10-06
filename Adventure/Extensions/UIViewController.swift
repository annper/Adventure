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
    
    child.view.frame = view.frame
    child.view.center = view.center
    
    child.didMove(toParentViewController: self)
  }
  
//
//  func addAndInform(childViewController: UIViewController, toView view: UIView, topInset: CGFloat = 0) {
//
//    childViewController.willMove(toParentViewController: self)
//
//    self.addChildViewController(childViewController)
//    view.addSubview(childViewController.view)
//
//    constrain(childViewController.view, view) { childViewControllerView, view in
//      childViewControllerView.leading == view.leading
//      childViewControllerView.trailing == view.trailing
//      childViewControllerView.top == view.top + topInset
//      childViewControllerView.bottom == view.bottom
//    }
//
//    childViewController.didMove(toParentViewController: self)
//  }
  
}
