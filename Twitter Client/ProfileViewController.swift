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
import ImageViewer

class ProfileViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Variables
    var collectionDataSource: CollectionDataSource<TweetCollectionCell, Tweet>!
    var stateCtrl: ProfileStateController!
    var previewedImage: UIImage!
    
    //MARK:- Segues
    
    
    //MARK:- View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configFlowLayout()
        
        ActivityIndicator.show()
        stateCtrl.getTweets { (error) in
            
            ActivityIndicator.hide()
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
            cell.imageViewProfile.sd_setImage(with: user?.profileImage, placeholderImage: #imageLiteral(resourceName: "ic_profile_placeholder"))
            
            cell.imageViewBackground.sd_setImage(with: user?.profileBackgroundImage, placeholderImage: #imageLiteral(resourceName: "bg_profile"))
            
            //code for add gestures 
            cell.delegate = self
            cell.setupTapGestures()
        }
        
        collectionDataSource = CollectionDataSource(cellID: "tweetCell", data: stateCtrl.tweets, configureCell: configureCell, configureHeader: configureHeader)
        
        collectionView.dataSource = collectionDataSource
        collectionView.reloadData()
    }
    
    //MARK:- IBActions

}

//MARK:- Image Previewing Section
extension ProfileViewController: StickyHeaderCellDelegate, GalleryItemsDataSource {
    func didTapImage(image: UIImage) {
        self.previewedImage = image
        let galleryViewController = GalleryViewController(startIndex: 0, itemsDataSource: self,
                                                          configuration: galleryConfiguration())
        
        self.presentImageGallery(galleryViewController)
    }
    
    /**
        construct configurations array
     **/
    func galleryConfiguration() -> GalleryConfiguration {
        return [
            
            GalleryConfigurationItem.closeButtonMode(.none),
            GalleryConfigurationItem.deleteButtonMode(.none),
            GalleryConfigurationItem.thumbnailsButtonMode(.none)
        ]
    }
    
    //MARK:- Gallery Delegate Section
    func itemCount() -> Int {
        return 1
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        return GalleryItem.image { $0(self.previewedImage) }
    }
    
}
