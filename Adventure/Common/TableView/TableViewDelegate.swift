//
//  TableViewDelegate.swift
//  Adventure
//
//  Created by Annie Persson on 03/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class TableViewDelegate<Model>: NSObject, UITableViewDelegate {
  typealias DidSelectRow = (Model) -> Void
  typealias DidEndScrolling = () -> Void
  
  private let didSelectRowAction: DidSelectRow
  private let didEndScrollingAction: DidEndScrolling
  
  init(selectedRow: @escaping DidSelectRow, endedScrolling: @escaping DidEndScrolling) {
    self.didSelectRowAction = selectedRow
    self.didEndScrollingAction = endedScrolling
  }
  
  convenience init(selectedRow: @escaping DidSelectRow) {
    self.init(selectedRow: selectedRow, endedScrolling: {})
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dataSource = tableView.dataSource as! TableViewDataSource<Model>
    let model = dataSource.models[indexPath.row]
    
    didSelectRowAction(model)
  }

  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    
    didEndScrollingAction()
  }
}
