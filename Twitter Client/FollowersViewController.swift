//
//  FollowersViewController.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import SDWebImage
import TwitterKit

class FollowersViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables
    var stateCtrl: FollowersStateController!
    var dataSource: TableDataSource<FollowerTVC, User>!
    var tableDelegate: FollowersTableDelegate!
    
    //MARK:- Segues
    let PROFILE_SEGUE = "fromFollowersToProfile"
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the current userID. This value should be managed by the developer but can be retrieved from the TWTRSessionStore.
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            self.constructStateCtrl(client: client)
            
        } else {
            //if there is no session in sessionStore, perform reLogin
            Twitter.sharedInstance().logIn { (session, error) in
                let client = TWTRAPIClient(userID: session?.userID)
                self.constructStateCtrl(client: client)
            }
        }
    }
    
    //MARK:- Configuratiuon
    func constructStateCtrl(client: TWTRAPIClient) {
        stateCtrl = FollowersStateController(client: client)
        
        stateCtrl.getFollowersList(completion: { error in
            if error != nil {
                return
            }
            self.setupTable()
        })
    }
    
    func setupTable() {
        tableDelegate = FollowersTableDelegate(listDelegate: self)
        
        dataSource = TableDataSource (cellID: FollowerTVC.CELL_ID, data: stateCtrl.users) { (cell, user) in
            
            cell.imageViewProfilePic.sd_setImage(with: user.profileImage)
            cell.labelName.text = user.name
            cell.labelUsername.text = "@\(user.screenName!)"
            cell.labelBio.text = user.descriptionField
        }
        
        tableView.delegate = tableDelegate
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PROFILE_SEGUE {
            let destinationVC = segue.destination as! ProfileViewController
            let user = sender as! User
            
            destinationVC.initStateCtrl(client: stateCtrl.client, user: user)
        }
    }
    
}

//MARK:- List View Delegate Extension
extension FollowersViewController: ListViewsDelegate {
    func didSelectItemAt(index: Int) {
        self.performSegue(withIdentifier: PROFILE_SEGUE,
                          sender: stateCtrl.users[index])
    }
}
