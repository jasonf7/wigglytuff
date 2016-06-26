//
//  LoginViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AuthenticationApiDelegate {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var birthDateField: UITextField!
    @IBOutlet weak var memberIdField: UITextField!

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstNameField.setupWithCustomStyle()
        lastNameField.setupWithCustomStyle()
        birthDateField.setupWithCustomStyle()
        memberIdField.setupWithCustomStyle()
        
        loginButton.setupWithNoBorderStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        AuthenticationApiService().performAuth("Danny", lastName: "Eng", memberId: "TESTER", delegate: self)
    }
    
    func showOnboarding() {
        let loginViewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateInitialViewController()!
        
        self.presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    func showMain() {
        let loginViewController = UIStoryboard(name: "Coverage", bundle: nil).instantiateInitialViewController()!
    
        self.presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    func onSuccess(newUser: Bool) {
        if newUser {
            showOnboarding()
        } else {
            showMain()
        }
    }
    
    func onError() {
        
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
