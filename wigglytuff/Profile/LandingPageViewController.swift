//
//  LandingPageViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class LandingPageViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UISearchBarDelegate, CategoryCollectionDelegate {

    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var searchContainerView: UIView!
    
    @IBOutlet weak var categoryContainerView: UIView!
    
    @IBOutlet weak var searchBarTop: NSLayoutConstraint!
    var pageViewController: UIPageViewController!
    var categoryCollectionViewControllers = [UIViewController]()
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = String.init(format: "Hi %@ %@", DataManager.sharedInstance.user.firstName, DataManager.sharedInstance.user.lastName)

        // Do any additional setup after loading the view.
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        let pageControlAppearance =  UIPageControl.appearanceWhenContainedInInstancesOfClasses([UIPageViewController.self])
        pageControlAppearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControlAppearance.currentPageIndicatorTintColor = UIColor.pokeColor()
        
        createCategoryCollectionViewControllers()
        
        self.pageViewController.setViewControllers([categoryCollectionViewControllers[0]], direction: .Forward, animated: false, completion: nil)
        
        self.categoryContainerView.addSubview(self.pageViewController.view)
        
        let searchSuggestionViewController = storyboard?.instantiateViewControllerWithIdentifier("searchSuggestionViewController") as! SearchSuggestionViewController
        searchController = UISearchController(searchResultsController: searchSuggestionViewController)
        searchController.searchResultsUpdater = searchSuggestionViewController
        
        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "i.e. Eye Exam"
        searchBar.delegate = self
        searchContainerView.addSubview(searchBar)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.pageViewController.view.frame = self.categoryContainerView.bounds
        
        self.profileImageButton.setupWithCircularStyle()
    }
    
    func createCategoryCollectionViewControllers() {
        for _ in 1...3 {
            let pageViewController = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewControllerWithIdentifier("categoryCollectionViewController") as! CategoryCollectionViewController
            
            pageViewController.filters = DataManager.sharedInstance.categories
            pageViewController.delegate = self
            
            categoryCollectionViewControllers.append(pageViewController)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let ind = categoryCollectionViewControllers.indexOf(viewController)!
        
        return ind != 0 ? categoryCollectionViewControllers[ind - 1] : nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let ind = categoryCollectionViewControllers.indexOf(viewController)!
        
        return ind != categoryCollectionViewControllers.count - 1 ? categoryCollectionViewControllers[ind + 1] : nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return categoryCollectionViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return categoryCollectionViewControllers.indexOf(pageViewController.viewControllers![0])!
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchBarTop.constant = 0
        
        self.welcomeLabel.hidden = true
        self.profileImageButton.hidden = true
        self.categoryContainerView.hidden = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBarTop.constant = 175
        
        self.welcomeLabel.hidden = false
        self.profileImageButton.hidden = false
        self.categoryContainerView.hidden = false
    }
    
    func onCategorySelected(categoryCollectionViewController: CategoryCollectionViewController, category: InsuranceCategory) {
        var coverageServiceViewController: UIViewController
            
        if category.name == "Family" {
            coverageServiceViewController  = storyboard!.instantiateViewControllerWithIdentifier("coverageFamilyViewController") as! CoverageFamilyViewController
        } else {
            let gg  = storyboard!.instantiateViewControllerWithIdentifier("coverageServiceViewController") as! CoverageServiceViewController
            gg.category = category
            coverageServiceViewController = gg
        }
        
        coverageServiceViewController.title = String(format: "%@ %@'s %@", DataManager.sharedInstance.user.firstName, DataManager.sharedInstance.user.lastName, category.name)
        
        self.presentViewController(coverageServiceViewController, animated: true, completion: nil)
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
