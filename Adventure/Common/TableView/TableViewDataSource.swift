//
//  TableViewDataSource.swift
//  Adventure
//
//  Created by Annie Persson on 03/10/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class Model {
  
}

class TableViewDataSource<Model>: NSObject,  UITableViewDataSource {
  
  typealias CellConfigurator = (Model, UITableViewCell) -> Void
  
  var models: [Model]
  
  private let reuseIdentifier: String
  private let cellConfigurator: CellConfigurator
  
  init(models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
    self.models = models
    self.reuseIdentifier = reuseIdentifier
    self.cellConfigurator = cellConfigurator
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = self.models[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
    
    cellConfigurator(model, cell)
    
    return cell
  }
  
}
