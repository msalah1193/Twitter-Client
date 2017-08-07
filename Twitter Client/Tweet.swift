//
//	Tweet.swift
//
//	Create by Mohamed Salah on 7/8/2017
//	Copyright © 2017 Mivors. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class Tweet{
    
    var createdAt : String!
    var favoriteCount : Int!
    var favorited : Bool!
    var id : Int!
    var idStr : String!
    var lang : String!
    var place : String!
    var retweetCount : Int!
    var retweeted : Bool!
    var source : String!
    var text : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        
        createdAt = json["created_at"].stringValue
        favoriteCount = json["favorite_count"].intValue
        favorited = json["favorited"].boolValue
        id = json["id"].intValue
        idStr = json["id_str"].stringValue
        lang = json["lang"].stringValue
        place = json["place"].stringValue
        retweetCount = json["retweet_count"].intValue
        retweeted = json["retweeted"].boolValue
        source = json["source"].stringValue
        text = json["text"].stringValue
    }
    
}
