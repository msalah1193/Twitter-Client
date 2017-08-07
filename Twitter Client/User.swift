//
//	User.swift
//
//	Create by Mohamed Salah on 5/8/2017
//	Copyright © 2017 Mivors. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON

class User{
    
    var descriptionField : String!
    var followersCount : Int!
    var following : Bool!
    var friendsCount : Int!
    var id : Int!
    var idStr : String!
    var lang : String!
    var name : String!
    var profileBackgroundColor : String!
    var profileBackgroundImageUrl : String!
    var profileBackgroundImageUrlHttps : String!
    var profileBackgroundTile : Bool!
    var profileBannerUrl : String!
    var profileImageUrl : String!
    var profileImageUrlHttps : String!
    var profileLinkColor : String!
    var profileSidebarBorderColor : String!
    var profileSidebarFillColor : String!
    var profileTextColor : String!
    var profileUseBackgroundImage : Bool!
    var screenName : String!
    var url : String!
    var profileImage : URL!
    var profileBackgroundImage : URL!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        
        descriptionField = json["description"].stringValue
        
        followersCount = json["followers_count"].intValue
        following = json["following"].boolValue
        friendsCount = json["friends_count"].intValue
        id = json["id"].intValue
        idStr = json["id_str"].stringValue
        lang = json["lang"].stringValue
        name = json["name"].stringValue
        profileBackgroundColor = json["profile_background_color"].stringValue
        profileBackgroundImageUrlHttps = json["profile_background_image_url_https"].stringValue
        profileBackgroundTile = json["profile_background_tile"].boolValue
        profileBannerUrl = json["profile_banner_url"].stringValue
        
        profileBackgroundImageUrl = json["profile_background_image_url"].stringValue
        profileBackgroundImage = URL(string: profileBackgroundImageUrl)
        
        profileImageUrl = json["profile_image_url"].stringValue
        profileImage = URL(string: profileImageUrl)
        
        profileImageUrlHttps = json["profile_image_url_https"].stringValue
        profileLinkColor = json["profile_link_color"].stringValue
        profileSidebarBorderColor = json["profile_sidebar_border_color"].stringValue
        profileSidebarFillColor = json["profile_sidebar_fill_color"].stringValue
        profileTextColor = json["profile_text_color"].stringValue
        profileUseBackgroundImage = json["profile_use_background_image"].boolValue
        screenName = json["screen_name"].stringValue
        url = json["url"].stringValue
        
    }
    
}
