//
//  ProfileStateController.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/7/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import Foundation
import TwitterKit
import SwiftyJSON

class ProfileStateController {
    //MARK: - Variables
    var client: TWTRAPIClient!
    var profileUser: User!
    var tweets: [Tweet] = []
    
    //MARK:- Init
    init(client: TWTRAPIClient, profileUser: User) {
        self.client = client
        self.profileUser = profileUser
    }
    
    //MARK: - Cache Followers
    
    
    //MARK:- PARSING
    
    
    
    //MARK:- API CALLS
    func getTweets(completion: @escaping (_ error: String?)->()) {
        let userTimelineEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        
        let params: [AnyHashable: Any] = ["id": profileUser.idStr, "count": "10"]
        var clientError : NSError?

        let request = client.urlRequest(withMethod: "GET",
                                        url: userTimelineEndpoint,
                                        parameters: params,
                                        error: &clientError)
        
        client.sendTwitterRequest(request) { (response, dataFromNetworking, connectionError) -> Void in
            if connectionError != nil {
                completion(connectionError?.localizedDescription)
                return
            }
            
            guard let jsonArray = JSON(data: dataFromNetworking!).array else {
                completion("No Tweets Available")
                return
            }
            
            for json in jsonArray {
                let newTweet = Tweet(fromJson: json)
                self.tweets.append(newTweet)
            }
            
            completion(nil)
        }
    }
    
    
}
