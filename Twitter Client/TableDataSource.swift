//
//  TableDataSource.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class TableDataSource<CellType: UITableViewCell, Model>: NSObject, UITableViewDataSource {
    
    //MARK:- Variables
    var cellIdentifier = ""
    var configureCell: (CellType, Model)->()!
    var data: [Model]!
    
    required init(cellID: String, data: [Model], configureCell: @escaping (CellType, Model)->()) {
        self.cellIdentifier = cellID
        self.data = data
        self.configureCell = configureCell
    }
    
    //MAKR:- Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CellType
        
        let model = data[indexPath.row]
        configureCell(cell, model)
        
        return cell
    }
    
}
