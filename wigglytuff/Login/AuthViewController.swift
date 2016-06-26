//
//  AuthViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, AuthenticationApiDelegate {
    
    weak var authService: AuthenticationApiService?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        autoLoginIfPossible()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func autoLoginIfPossible() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.removeObjectForKey("firstName")
        
        if let firstName = userDefaults.stringForKey("firstName") {
            let lastName = userDefaults.stringForKey("lastName")!
            let memberId = userDefaults.stringForKey("memberId")!
            
            AuthenticationApiService().performAuth(firstName, lastName: lastName, memberId: memberId, delegate: self)
        } else {
            showLogin()
        }
    }
    
    func showLogin() {
        let loginViewController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()!
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginViewController
    }
    
    func showOnboarding() {
        let loginViewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()!
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginViewController
    }
    
    func showMain() {
        let loginViewController = UIStoryboard(name: "Coverage", bundle: nil).instantiateInitialViewController()!
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginViewController
    }
    
    func onSuccess(newUser: Bool) {
        if newUser {
            showOnboarding()
        } else {
            showMain()
        }
    }
    
    func onError() {
        showLogin()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
