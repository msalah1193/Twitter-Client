//
//  FollowerCVC.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/8/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class FollowerCVC: UICollectionViewCell {
    @IBOutlet weak var imageViewProfilePic: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelBio: UILabel!
    
    //MARK:- IDENTIFIER
    public static let CELL_ID = "FollowerCollectionCell"
    public static let cellWidth: CGFloat = (max(UIScreen.main.bounds.height,
                                                UIScreen.main.bounds.width) / 2.0 ) - 10.0
}
