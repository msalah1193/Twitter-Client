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
    init(client: TWTRAPIClient) {
        self.client = client
    }
    
    //MARK: - Cache Followers
    func cacheFollowersResponse (_ data: Data)-> Bool {
        
        return UserDefaultsManager.save(data,
                                        forKey: AppKeys.followersData.rawValue)
    }
    
    func getCachedFollowersResponse ()-> Data? {
        return UserDefaultsManager.getData(forKey: AppKeys.followersData.rawValue)
    }
    
    //MARK:- PARSING
    func setDataValues (_ data: Data) {
        let json = JSON(data: data)
        
        let usersArray = json["users"].arrayValue
        for usersJson in usersArray{
            let value = User(fromJson: usersJson)
            self.users.append(value)
        }
        
        self.cursor = json["next_cursor"].stringValue
    }
    
    
    //MARK:- API CALLS
    func getFollowersList(completion: @escaping (_ error: String?)->()) {
        let followersGetEndpoint = "https://api.twitter.com/1.1/followers/list.json"
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET",
                                        url: followersGetEndpoint,
                                        parameters: nil,
                                        error: &clientError)
        
        client.sendTwitterRequest(request) { (response, dataFromNetworking, connectionError) -> Void in
            if connectionError != nil {
                //get Cached Data 
                guard let cachedData = self.getCachedFollowersResponse() else {
                    completion(connectionError?.localizedDescription)
                    return
                }
                
                self.setDataValues(cachedData)
                completion(nil)
                return
            }
            
            
            var errorMessage: String!
            if !self.cacheFollowersResponse(dataFromNetworking!) {
                errorMessage = "Error in Data Caching"
            }
            
            self.setDataValues(dataFromNetworking!)
            completion(errorMessage)
        }
    }
}
