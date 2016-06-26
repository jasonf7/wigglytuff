//
//  CoverageServiceViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit
import CircleProgressBar

class CoverageServiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var serviceSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var mainProgressBar: CircleProgressBar!
    @IBOutlet weak var deductibleLabel: UILabel!
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!

    @IBOutlet weak var tipTableView: UITableView!
    
    @IBOutlet weak var providerNameLabel: UILabel!
    @IBOutlet weak var providerAddressLabel: UILabel!
    
    @IBOutlet weak var providerNumberLabel: UILabel!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var directionsButton: UIButton!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var category: InsuranceCategory!
    
    var coverage: Coverage?
    var serviceName: String?
    
    static let cellIdentifier = "coverageTipTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if category == nil {
            self.title = serviceName
            navigationBar.removeFromSuperview()
        } else {
            navigationBar.topItem?.title = String.init(format: "%@ %@'s %@", DataManager.sharedInstance.user.firstName, DataManager.sharedInstance.user.lastName, category.name)
        }
        
        tipTableView.separatorStyle = .None
        
        callButton.setupWithRoundStyle()
        directionsButton.setupWithRoundStyle()
        
        providerNameLabel.text = DataManager.sharedInstance.provider.name
        providerAddressLabel.text = String(format: "%@, ", DataManager.sharedInstance.provider.address, DataManager.sharedInstance.provider.city)
        providerNumberLabel.text = DataManager.sharedInstance.provider.phoneNumber
        
        if let _ = coverage, let name = serviceName {
            serviceSegmentedControl.removeFromSuperview()
            populateWithService(name)
        } else {
            populateWithService("physician_visit_office_sick")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func serviceControlChanged(sender: UISegmentedControl) {
        let service = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "_")
        
        populateWithService(service)
        
    }
    
    @IBAction func dismissButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CoverageServiceViewController.cellIdentifier) as! CoverageTipTableViewCell
        
        if indexPath.row == 0 {
            cell.tipLabel.text = "Co-Pay: $25"
        } else if indexPath.row == 1 {
            cell.tipLabel.text = "Pay nothing after Deductibles/Co-pay"
        } else {
            cell.tipLabel.text = "You can do it!"
        }
        
        return cell
    }
    
    func populateWithService(service: String) {
        var coverage: Coverage
        if category == nil {
            coverage = self.coverage!
        } else {
            coverage = DataManager.sharedInstance.coverage[category.camelCaseName]![service]!
        }
        
        let progress = CGFloat(coverage.deductible.spent / coverage.deductible.total)
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        
        mainProgressBar.setProgress(progress, animated: true)
        mainProgressBar.setHintAttributedGenerationBlock({ (progress) -> (NSAttributedString) in
            NSAttributedString(
                string: "Remaining:\n" + formatter.stringFromNumber(NSNumber(double: coverage.deductible.remaining))!,
                attributes: [NSFontAttributeName: UIFont.systemFontOfSize(13)])
        })
        
        deductibleLabel.text = formatter.stringFromNumber(NSNumber(double: coverage.deductible.total))
        spentLabel.text = formatter.stringFromNumber(NSNumber(double: coverage.deductible.spent))
        remainingLabel.text = formatter.stringFromNumber(NSNumber(double: coverage.deductible.remaining))
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
