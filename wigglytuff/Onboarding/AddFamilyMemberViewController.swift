//
//  AddFamilyMemberViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class AddFamilyMemberViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    static let cellIdentifier = "addFamilyMemberTableViewCell"
    
    var familyMembers = [FamilyMember()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addButton.setupWithNoBorderStyle()
        doneButton.setupWithNoBorderStyle()
        
        tableView.separatorStyle = .None
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(skipButtonPressed))
        
        let member = FamilyMember(firstName: "Jane", lastName: "Doe", birthDate: NSDate(), memberId: "W000000000")
        DataManager.sharedInstance.family = member
        print("START")
        FamilyMemberApiService().addFamilyMembers([member], delegate: { () -> Void in
            print("DONEEEEEEE")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func skipButtonPressed() {
        let onboardFinishViewController = storyboard!.instantiateViewControllerWithIdentifier("onboardingFinishViewController") as! OnboardingFinishViewController
        
        self.navigationController?.pushViewController(onboardFinishViewController, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func addButtonPressed(sender: UIButton) {
        familyMembers.append(FamilyMember())
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return familyMembers.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AddFamilyMemberViewController.cellIdentifier) as! AddFamilyMemberTableViewCell
        
        cell.numberLabel.text = String(indexPath.row + 1) + "."
        cell.selectionStyle = .None
        
        return cell
    }
 

}
