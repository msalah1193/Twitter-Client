//
//  Locale.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/9/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import Foundation

enum Locale: String {
    case cacheError = "CacheError"
    case noTweets = "NoTweets"
    case unknowError = "UnknowError"
    case loginFail = "LoginFail"
    case ok = "OK"
    case networkError = "networkError"
}

extension Locale {
    var localized: String {
        return NSLocalizedString(self.rawValue, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
