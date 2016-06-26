//
//  SearchSuggestionViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class SearchSuggestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, SearchKeywordApiDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    static let cellIdentifier = "searchSuggestionTableViewCell"
    
    var matchedServices = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SearchKeywordApiService().getSearchKeywords(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onSuccess() {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchKeywords = DataManager.sharedInstance.searchKeywords, let searchBarText = searchController.searchBar.text else {
            return
        }
        
        matchedServices = [String]()
        
        let queryKeywords = Set(searchBarText.lowercaseString.componentsSeparatedByString(" "))
        
        for (service, keywords) in searchKeywords {
            let intersection = queryKeywords.intersect(keywords)
            
            if !intersection.isEmpty {
                matchedServices.append(service)
            }
        }
        
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedServices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SearchSuggestionViewController.cellIdentifier) as! SearchSuggestionTableViewCell
        
        cell.serviceLabel.text = matchedServices[indexPath.row]
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let service = matchedServices[indexPath.row]
        
        var found = false
        for (_, serviceMap) in DataManager.sharedInstance.coverage {
            for (serv, coverage) in serviceMap {
                if service == serv {
                    let coverageController = storyboard!.instantiateViewControllerWithIdentifier("coverageServiceViewController") as! CoverageServiceViewController
                    
                    coverageController.serviceName = service
                    coverageController.coverage = coverage
                    
                    self.presentingViewController!.navigationController!.pushViewController(coverageController, animated: true)
                    
                    found = true
                }
            }
        }
        
        if !found {
            let noCoverageViewController = storyboard!.instantiateViewControllerWithIdentifier("noCoverageViewController") as! NoCoverageViewController
            
            noCoverageViewController.title = service
            
            self.presentingViewController!.navigationController!.pushViewController(noCoverageViewController, animated: true)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
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
