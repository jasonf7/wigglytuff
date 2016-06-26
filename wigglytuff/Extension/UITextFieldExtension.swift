//
//  UITextFieldExtension.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setupWithCustomStyle() {
        self.attributedPlaceholder = NSAttributedString(
            string: self.placeholder!,
            attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        let border = CALayer()
        let width : CGFloat = 1.0
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}