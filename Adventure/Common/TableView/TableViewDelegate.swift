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
  
  private let didSelectRowAction: DidSelectRow
  
  init(selectedRow: @escaping DidSelectRow) {
    self.didSelectRowAction = selectedRow
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dataSource = tableView.dataSource as! TableViewDataSource<Model>
    let model = dataSource.models[indexPath.row]
    
    didSelectRowAction(model)
  }
}
