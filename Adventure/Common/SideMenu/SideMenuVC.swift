//
//  SideMenuVC.swift
//  BoASCApp
//
//  Created by Annie Persson on 26/09/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

protocol SideMenuDelegate {
  func menuDidOpen()
  func menuDidClose()
  func didTapMenuItem(_ item: MenuItem)
}

public class SideMenuVC: UIViewController {
  
  var isOpen: Bool {
    return self._isOpen
  }
  
  var delegate: SideMenuDelegate?
  
  private var _isOpen: Bool = false { didSet {
    
    // Make sure the menu doesnt block content behind it while active
    self.view.isUserInteractionEnabled = self._isOpen
  }}
  
  private var items: [MenuItem]!
  private let reuseIdentifier = MenuItem.reuseIdentifier
  
  private let transitionViewMaxAlpha: CGFloat = 0.5
  private let menuWidth: CGFloat = UIScreen.main.bounds.width * 0.75

  private lazy var dataSource: TableViewDataSource<MenuItem> = {
    let temp = TableViewDataSource(models: items, reuseIdentifier: self.reuseIdentifier, cellConfigurator: { (item, cell) in
      cell.textLabel?.text = item.title
      cell.imageView?.image = item.image
    })
    
    return temp
  }()
  
  lazy var tableViewDelegate: TableViewDelegate<MenuItem> = {
    let temp = TableViewDelegate<MenuItem>(selectedRow: { (model) in
      Logger.info("did tap menu row with title: \(model.title)")
      
      if let delegate = self.delegate {
        delegate.didTapMenuItem(model)
      }
    })
    
    return temp
  }()
  
  convenience init(items: [MenuItem]) {
    self.init()
    self.items = items
  }
  
  @IBOutlet var transitionView: UIView! { didSet {
    self.transitionView.alpha = 0
    self.transitionView.isHidden = true
    
    self.transitionView.isUserInteractionEnabled = true
    let recogniser = UITapGestureRecognizer(target: self, action: #selector(didTapTransitionView))
    self.transitionView.addGestureRecognizer(recogniser)
  }}
  
  @IBOutlet var tableView: UITableView! { didSet {
    self.tableView.tableFooterView = UIView()
    self.tableView.dataSource = self.dataSource
    self.tableView.delegate = self.tableViewDelegate
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
  }}
  
  @IBOutlet var tableViewWidthConstraint: NSLayoutConstraint! { didSet {
    self.tableViewWidthConstraint.constant = self.menuWidth
  }}
  
  @IBOutlet var menuLeadingConstraint: NSLayoutConstraint! { didSet {
    self.menuLeadingConstraint.constant = -self.menuWidth
  }}
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.isUserInteractionEnabled = false
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }
  
  public override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    if self.isOpen {
      self.hideMenu()
    }
  }
  
}

public extension SideMenuVC {
  
  func openMenu() {
    
    self.menuLeadingConstraint.constant = 0
    
    self.transitionView.isHidden = false
    
    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
      self.transitionView.alpha = self.transitionViewMaxAlpha
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
      self.transitionView.alpha = self.transitionViewMaxAlpha
    }) { (_) in
      self._isOpen = true
      
      if let delegate = self.delegate {
        delegate.menuDidOpen()
      }
    }
    
  }
  
  func hideMenu() {
    
    self.menuLeadingConstraint.constant = -self.menuWidth
    
    UIView.animate(withDuration: 0.3, animations: {
      self.view.layoutIfNeeded()
      self.transitionView.alpha = 0
    }) { (_) in
      self.transitionView.isHidden = true
      self._isOpen = false
    }
    
    if let delegate = self.delegate {
      delegate.menuDidClose()
    }
  }
  
}

private extension SideMenuVC {
  
  @objc func didTapTransitionView() {
    self.hideMenu()
  }
  
}

class MenuItem: Model {
  
  static let reuseIdentifier = "menuItem"
  
  let id: Int
  let title: String
  let image: UIImage?
  
  init(id: Int, title: String, image: UIImage?) {
    self.id = id
    self.title = title
    self.image = image
  }
  
}


