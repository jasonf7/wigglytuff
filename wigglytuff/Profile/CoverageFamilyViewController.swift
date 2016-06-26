//
//  CoverageFamilyViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class CoverageFamilyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var familyTableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    static let cellIdentifier = "coverageFamilyTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        familyTableView.separatorStyle = .None
        
        navigationBar.topItem?.title = String.init(format: "%@ %@'s Family", DataManager.sharedInstance.user.firstName, DataManager.sharedInstance.user.lastName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CoverageFamilyViewController.cellIdentifier) as! CoverageFamilyTableViewCell
        
        cell.nameLabel.text = String(format: "%@ %@", DataManager.sharedInstance.family.firstName, DataManager.sharedInstance.family.lastName)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        cell.birthDateLabel.text = formatter.stringFromDate(DataManager.sharedInstance.family.birthDate)
        cell.idLabel.text = DataManager.sharedInstance.family.memberId
        
        cell.selectionStyle = .None
        
        return cell
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
