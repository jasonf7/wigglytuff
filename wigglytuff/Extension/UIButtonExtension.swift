//
//  UIButtonExtension.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setupWithRoundStyle() {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.pokeColor().CGColor
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    func setupWithFilledRoundStyle() {
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.backgroundColor = UIColor.pokeColor()
    }
    
    func setupWithNoBorderStyle() {
        self.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
    }
    
    func setupWithCircularStyle() {
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true
        
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.pokeColor().CGColor
    }
    
    
}