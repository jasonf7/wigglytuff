//
//  CategorySelectionViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class CategorySelectionViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    var pageViewController: UIPageViewController!
    var categoryCollectionViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        let pageControlAppearance =  UIPageControl.appearanceWhenContainedInInstancesOfClasses([UIPageViewController.self])
        pageControlAppearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControlAppearance.currentPageIndicatorTintColor = UIColor.pokeColor()
        
        createCategoryCollectionViewControllers()
        
        self.pageViewController.setViewControllers([categoryCollectionViewControllers[0]], direction: .Forward, animated: false, completion: nil)
        
        self.containerView.addSubview(self.pageViewController.view)
        
        self.confirmButton.setupWithNoBorderStyle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.pageViewController.view.frame = self.containerView.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.hidden = false
    }
    
    func createCategoryCollectionViewControllers() {
        for _ in 1...3 {
            let pageViewController = storyboard!.instantiateViewControllerWithIdentifier("categoryCollectionViewController") as! CategoryCollectionViewController
            
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
    

    @IBAction func confirmButtonPressed(sender: UIButton) {
        let categories = (categoryCollectionViewControllers[0] as! CategoryCollectionViewController).getSelectedCategories()
        
        CategoryApiService().addCategories(categories, delegate: { () -> Void in
        })
    }

}
