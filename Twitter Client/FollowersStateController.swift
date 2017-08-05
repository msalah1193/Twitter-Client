//
//  FollowersStateController.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import Foundation
import TwitterKit
import SwiftyJSON

class FollowersStateController{
    //MARK: - Variables
    var client: TWTRAPIClient!
    var cursor: String = ""
    var users: [User] = []
    
    //MARK:- Init
    init() {
        // Get the current userID. This value should be managed by the developer but can be retrieved from the TWTRSessionStore.
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            self.client = TWTRAPIClient(userID: userID)
        }
    }
    
    //MARK: - Filtring
    
    
    //MARK:- API CALLS
    func getFollowersList(completion: @escaping (_ error: String?)->()) {
        let statusesShowEndpoint = "https://api.twitter.com/1.1/followers/list.json"
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET",
                                        url: statusesShowEndpoint,
                                        parameters: nil,
                                        error: &clientError)
        
        client.sendTwitterRequest(request) { (response, dataFromNetworking, connectionError) -> Void in
            if connectionError != nil {
                completion(connectionError?.localizedDescription)
                return
            }
            
            let json = JSON(data: dataFromNetworking!)
            
            let usersArray = json["users"].arrayValue
            for usersJson in usersArray{
                let value = User(fromJson: usersJson)
                self.users.append(value)
            }
            
            self.cursor = json["next_cursor"].stringValue
            
            completion(nil)
        }
    }
}
