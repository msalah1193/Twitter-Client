//
//  FollowerTVC.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class FollowerTVC: UITableViewCell {
    
    @IBOutlet weak var imageViewProfilePic: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelBio: UILabel!
    
    //MARK:- IDENTIFIER
    public static let CELL_ID = "FollowerCell"
}
