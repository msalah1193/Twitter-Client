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
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables
    var stateCtrl: FollowersStateController!
    var tableDataSource: TableDataSource<FollowerTVC, User>!
    var collectionDataSource: CollectionDataSource<FollowerCVC, User>!
    
    var tableDelegate: FollowersTableDelegate!
    var collectionDelegate: CollectionViewDelegate!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(FollowersViewController.checkOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        checkOrientation()
    }
    
    //MARK:- Configuratiuon
    func constructStateCtrl(client: TWTRAPIClient) {
        stateCtrl = FollowersStateController(client: client)
        
        ActivityIndicator.show()
        
        stateCtrl.getFollowersList(completion: { error in
            ActivityIndicator.hide()
            if error != nil {
                return
            }
            self.setupTable()
            self.setupCollection()
        })
    }
    
    func checkOrientation() {
        let orientation = UIApplication.shared.statusBarOrientation
        
        if (orientation == .portrait || orientation == .portraitUpsideDown) {
            tableView.alpha = 1
            collectionView.alpha = 0
            
        } else {
            tableView.alpha = 0
            collectionView.alpha = 1
        }
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

//MARK:- Lists Config
extension FollowersViewController {
    func setupTable() {
        tableDelegate = FollowersTableDelegate(listDelegate: self)
        
        tableDataSource = TableDataSource (cellID: FollowerTVC.CELL_ID, data: stateCtrl.users) { (cell, user) in
            
            cell.imageViewProfilePic.sd_setImage(with: user.profileImage)
            cell.labelName.text = user.name
            cell.labelUsername.text = "@\(user.screenName!)"
            cell.labelBio.text = user.descriptionField
        }
        
        tableView.delegate = tableDelegate
        tableView.dataSource = tableDataSource
        tableView.reloadData()
    }
    
    func setupCollection() {
        let cellSize  = CGSize(width: FollowerCVC.cellWidth, height: 146)
        collectionDelegate = CollectionViewDelegate(cellSize: cellSize, self)
        
        collectionDataSource = CollectionDataSource(cellID: FollowerCVC.CELL_ID, data: stateCtrl.users, configureCell: { (cell, user) in
            
            cell.imageViewProfilePic.sd_setImage(with: user.profileImage)
            cell.labelName.text = user.name
            cell.labelUsername.text = "@\(user.screenName!)"
            cell.labelBio.text = user.descriptionField
            
        })
        
        collectionView.delegate = collectionDelegate
        collectionView.dataSource = collectionDataSource
        collectionView.reloadData()
    }
    
}

