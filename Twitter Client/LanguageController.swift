//
//  LanguageController.swift
//  LocalizeTest
//
//  Created by Mohamed Salah on 1/8/17.
//  Copyright © 2017 Mivors. All rights reserved.
//

import UIKit

class LanguageController {
    /**
        gets the current app language
     
        - Returns: current language string
     **/
    class func currentLanguage () -> String {
        
        let defaults = UserDefaults.standard
        
        let langs = defaults.object(forKey: Languages.keyForAll.rawValue) as! NSArray
        let firstLang = langs.firstObject as! String
        
        return firstLang
    }
    
    /**
        sets app language
        
        - Parameter lang : language name
     **/
    class func setAppLanguage (lang : String) {
        let defaults = UserDefaults.standard
        
        defaults.set([lang, currentLanguage()], forKey: Languages.keyForAll.rawValue)
        defaults.synchronize()
    }
    
    /**
     changes the application language then refresh view
     
     - Parameter storyboardName : takes the storyboard name of refresh view controller
     - Parameter viewControllerID : takes the view controller id will be refreshed
     - Parameter transition : takes the animation will occured while refreshing view

     **/
    class func changeLanguage(language: Languages, transition : UIViewAnimationOptions) {
        
        LanguageController.setAppLanguage(lang: language.rawValue)
        
        // set LocaleString to be used to call the right url
        if language == .ar {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "FollowersNVC")
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        
        UIView.transition(with: window!, duration: 0.5, options: transition, animations: nil, completion: nil)
        
    }
}
