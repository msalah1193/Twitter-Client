//
//  ActivityIndicator.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/8/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import Foundation

class ActivityIndicator {
    
    static func show() {
        ALLoadingView.manager.showLoadingView(ofType: .basic, windowMode: .fullscreen)
    }
    
    static func hide() {
        ALLoadingView.manager.hideLoadingView(withDelay: 0.0)
    }
}
