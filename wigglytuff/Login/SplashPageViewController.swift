//
//  SplashPageViewController.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import UIKit

class SplashPageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
    
    weak var splashPageInfo: SplashPageInfo?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let info = splashPageInfo {
            imageView.image = info.image
            msgLabel.text = info.message
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
