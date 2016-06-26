//
//  ProfileViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var planNumberLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var benefitsButton: UIButton!
    @IBOutlet weak var familyMemberButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cardBackgroundView.layer.borderWidth = 1.5
        self.cardBackgroundView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.cardBackgroundView.layer.cornerRadius = 5.0
        
        cardNumberLabel.text = DataManager.sharedInstance.user.memberId
        cardNameLabel.text = DataManager.sharedInstance.user.firstName + " " + DataManager.sharedInstance.user.lastName
        
        planNameLabel.text = DataManager.sharedInstance.plan.description
        planNumberLabel.text = DataManager.sharedInstance.plan.number
        
        logoutButton.setupWithNoBorderStyle()
        uploadButton.setupWithNoBorderStyle()
        benefitsButton.setupWithNoBorderStyle()
        familyMemberButton.setupWithNoBorderStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
