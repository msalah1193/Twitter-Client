//
//  FollowersViewController.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import SDWebImage

class FollowersViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables
    var stateCtrl: FollowersStateController!
    var dataSource: TableDataSource<FollowerTVC, User>!
    var tableDelegate: FollowersTableDelegate!
    
    
    let CELL_ID = "FollowerCell"
    //MARK:- Segues
    
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateCtrl = FollowersStateController()
        stateCtrl.getFollowersList(completion: { error in
            if error != nil {
                return
            }
            self.setupTable()
        })
    }
    
    //MARK:- Configuratiuon
    func setupTable() {
        tableDelegate = FollowersTableDelegate()
        
        dataSource = TableDataSource(cellID: CELL_ID, data: stateCtrl.users, configureCell: { (cell, user) in
            cell.imageViewProfilePic.sd_setImage(with: user.profileImage)
            cell.labelName.text = user.name
            cell.labelUsername.text = "@\(user.screenName!)"
            cell.labelBio.text = user.descriptionField
        })
        
        tableView.delegate = tableDelegate
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    //MARK:- IBActions
    
}
