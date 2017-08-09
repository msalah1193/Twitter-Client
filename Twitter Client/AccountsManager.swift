//
//  AccountsManager.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import Foundation
import Accounts
import Social

class AccountsManager {
    
    //MARK:- Methods
    static func requestAccessToSettings(completionHandler: @escaping (_ granted: Bool, _ error: Error?)->()) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        
        // Prompt the user for permission to their twitter account stored in the phone's settings
        accountStore.requestAccessToAccounts(with: accountType,
                                             options: nil,
                                             completion: completionHandler)
    }
    
    /**
        Takes username and search for it on Settings
     **/
    static func isAccountExist(with username: String)-> Bool {
        let accounts = AccountsManager.getTwitterAccounts()
        
        for account in accounts {
            if account.username != nil
                && account.username == username {
                
                return true
            }
        }
        
        return false
    }
    
    /**
        Gets All Twitter Accounts
     **/
    static func getTwitterAccounts ()-> [ACAccount] {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        let accounts = accountStore.accounts(with: accountType) as! [ACAccount]
        
        return accounts
    }
    
}
