//
//  InsuranceCategory.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import UIKit

class InsuranceCategory {
    var name: String
    var camelCaseName: String
    var image: UIImage
    var selected: Bool
    
    init(name: String, camelCaseName: String, image: UIImage) {
        self.name = name
        self.camelCaseName = camelCaseName
        self.image = image
        self.selected = false
    }
}