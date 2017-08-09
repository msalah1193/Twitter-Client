//
//  Localizer.swift
//  LocalizeTest
//
//  Created by Mohamed Salah on 1/8/17.
//  Copyright © 2017 Mivors. All rights reserved.
//

import UIKit

class Localizer {
    
    /**
        Change implmentation of localizedStringForKey
        Call it in AppDelegate UIApplicationLaunchOptionsKey
     **/
    class func exchangeNow () {
        ExchangeMethodsForClass(className: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.customLocalizedString(for:value:table:)))
        
        ExchangeMethodsForClass(className: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.custom_interfaceDirection))
        
        ExchangeMethodsForClass(className: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))
    }
}

extension UILabel {
    public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        
        if self.tag < 0  {
            if UIApplication.isRTL()  {
                if self.textAlignment == .right {
                    return
                }
            } else {
                if self.textAlignment == .left {
                    return
                }
            }
        }
        if self.tag < 0 {
            if UIApplication.isRTL()  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}

extension Bundle {
    func customLocalizedString(for Key: String, value: String?, table tableName: String) -> String {
        let currentLanguage = LanguageController.currentLanguage()
        var bundle = Bundle()
        
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle(path: path)!
        } else {
            let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
            bundle = Bundle(path: path!)!
        }
        
        return bundle.customLocalizedString(for: Key, value: value, table: tableName)
    }
}

extension UIApplication {
    var custom_interfaceDirection : UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            
            if LanguageController.currentLanguage() == Languages.ar.rawValue {
                direction = UIUserInterfaceLayoutDirection.rightToLeft
            }
            
            return direction
        }
    }
    
    class func isRTL() -> Bool{
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}


/**
 Exchanges Method Implementation in a class with new implementation
 
 - Parameter className : the class contains the method to be replaced
 - Parameter originalSelector : selector of the original method
 - Parameter overrideSelector : selector of the new method
 
 **/
func ExchangeMethodsForClass (className : AnyClass, originalSelector : Selector, overrideSelector : Selector) {
    
    let originalMethod : Method = class_getInstanceMethod(className, originalSelector)
    let overrideMethod : Method = class_getInstanceMethod(className, overrideSelector)
    
    if class_addMethod(className, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod)) {
        
        class_replaceMethod(className, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod)
    }
}
