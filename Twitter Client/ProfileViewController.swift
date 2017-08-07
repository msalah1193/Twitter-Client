//
//  ProfileViewController.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/7/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import TwitterKit
import CSStickyHeaderFlowLayout

class ProfileViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables
    var collectionDataSource: CollectionDataSource<TweetCollectionCell, Tweet>!
    var stateCtrl: ProfileStateController!
    
    //MARK:- Segues
    
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configFlowLayout()
        
        stateCtrl.getTweets { (error) in
            if error != nil {
                return
            }
            
            self.setupCollection()
        }
    }
    
    //MARK:- Configuratiuon
    func initStateCtrl (client: TWTRAPIClient, user: User) {
        stateCtrl = ProfileStateController(client: client,
                                           profileUser: user)
    }
    
    func configFlowLayout() {
        let layout = collectionView.collectionViewLayout as! CSStickyHeaderFlowLayout
        
        //set sizes for header and item
        layout.parallaxHeaderReferenceSize = CGSize(width: self.view.frame.size.width, height: 200)
        
        layout.itemSize = CGSize(width: self.view.frame.size.width - 16,
                                 height: 106)
        
        // add sticky header
        let stickyCellNib = UINib(nibName: "StickyCell", bundle: nil)
        collectionView.register(stickyCellNib,
                                forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader,
                                withReuseIdentifier: "StickyCell")
    }
    
    func setupCollection() {
        
        let configureCell = { (cell: TweetCollectionCell, tweet: Tweet) in
            let user = self.stateCtrl.profileUser
            
            cell.labelName.text = user?.name
            cell.labelUsername.text = "@\(user?.screenName ?? "")"
            cell.imageViewProfile.sd_setImage(with: user?.profileImage)
            cell.labelTweetText.text = tweet.text
        }
        let configureHeader = { (cell: StickyHeaderCell) in
            let user = self.stateCtrl.profileUser
            cell.labelName.text = user?.name
            cell.labelUsername.text = "@\(user?.screenName ?? "")"
            cell.imageViewProfile.sd_setImage(with: user?.profileImage)
            cell.imageViewBackground.sd_setImage(with: user?.profileBackgroundImage)
        }
        
        collectionDataSource = CollectionDataSource(cellID: "tweetCell", data: stateCtrl.tweets, configureCell: configureCell, configureHeader: configureHeader)
        
        collectionView.dataSource = collectionDataSource
        collectionView.reloadData()
    }
    
    //MARK:- IBActions

}
