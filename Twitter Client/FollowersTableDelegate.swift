//
//  FollowersTableDelegate.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class FollowersTableDelegate: NSObject, UITableViewDelegate {
    
    //MARK:- Variables
    
    override init() {
        
    }
    
    //MAKR:- Delegate Methods
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
