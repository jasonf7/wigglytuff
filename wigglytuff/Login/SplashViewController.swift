//
//  SplashViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    static let splashPageInfos = [
        SplashPageInfo(image: UIImage(named: "smartphone")!, message: "Your health benefits in the palm of your hands."),
        SplashPageInfo(image: UIImage(named: "pills-more")!, message: "Keep track of your coverages."),
        SplashPageInfo(image: UIImage(named: "heart")!, message: "Make sure your loved ones are healthy"),
        SplashPageInfo(image: UIImage(named: "nurse-short")!, message: "Welcome to Pokedex.")
    ]
    
    var pageViewController: UIPageViewController!
    var splashPageViewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        let pageControlAppearance =  UIPageControl.appearanceWhenContainedInInstancesOfClasses([UIPageViewController.self])
        pageControlAppearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControlAppearance.currentPageIndicatorTintColor = UIColor.pokeColor()
        
        createSplashPageViewControllers()
        
        self.pageViewController.setViewControllers([splashPageViewControllers[0]], direction: .Forward, animated: false, completion: nil)
        
        self.containerView.addSubview(self.pageViewController.view)
        
        getStartedButton.setupWithFilledRoundStyle()
        
        self.navigationController?.navigationBar.hidden = true
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
    
    func createSplashPageViewControllers() {
        for info in SplashViewController.splashPageInfos {
            let pageViewController = storyboard!.instantiateViewControllerWithIdentifier("splashPageViewController") as! SplashPageViewController
            
            pageViewController.splashPageInfo = info
            
            splashPageViewControllers.append(pageViewController)
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let ind = splashPageViewControllers.indexOf(viewController)!
        
        return ind != 0 ? splashPageViewControllers[ind - 1] : nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let ind = splashPageViewControllers.indexOf(viewController)!
        
        return ind != splashPageViewControllers.count - 1 ? splashPageViewControllers[ind + 1] : nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return splashPageViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return splashPageViewControllers.indexOf(pageViewController.viewControllers![0])!
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
