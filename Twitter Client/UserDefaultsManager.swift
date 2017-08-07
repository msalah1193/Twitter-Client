//
//  UserDefaultsManager.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    //MARK:- CURD Methods
    
    static func save(_ value: Any, forKey: String) -> Bool {
        let preferences = UserDefaults.standard
        
        preferences.setValue(value, forKey: forKey)
        
        //  Save Key
        let status = preferences.synchronize()
        
        return status
    }
    
    static func getvalue (forKey: String) -> String? {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: forKey) == nil {
            return nil
        } else {
            return preferences.string(forKey: forKey)!
        }
    }
    
    static func getData (forKey: String) -> Data? {
        let preferences = UserDefaults.standard
        
        if preferences.object(forKey: forKey) == nil {
            return nil
        } else {
            return preferences.data(forKey: forKey)!
        }
    }

}
