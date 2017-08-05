//
//  LoginViewController.swift
//  Twitter Client
//
//  Created by Mohamed Salah on 8/5/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    //MARK:- IBOutlets
    
    
    //MARK:- Variables
    var twitterAccount: ACAccount?
    
    //MARK:- Segues
    let FOLLOWERS_SEGUE = "FromLoginToFollowers"
    
    //MARK:- View Controller Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLoginBtnToView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Configuratiuon
    func addLoginBtnToView() {
        // Add Login Button
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                self.handleLoginSuccess(session!)
            } else {
                self.handle(error: error)
            }
        })
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    //MARK:- IBActions
    
}

//MARK:- Twitter Login Extension
extension LoginViewController {
    func handleLoginSuccess(_ session: TWTRSession) {
        if UserDefaultsManager.save(session.userName, forKey: AppKeys.username.rawValue) {
            self.performSegue(withIdentifier: FOLLOWERS_SEGUE, sender: nil)
        
        } else {
            self.handle(error: nil)
        }
    }
    
    func handle(error: Error?) {
        var errorMessage = "UnKnown Error"
        
        if let wrappedError = error {
            errorMessage = wrappedError.localizedDescription
        }
        
        _ = SweetAlert().showAlert("Login Failed",
                                   subTitle: errorMessage,
                                   style: AlertStyle.error,
                                   buttonTitle: "OK",
                                   buttonColor: UIColor.twitterBlue)
    }
}

