//
//  Deductible.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation

class Deductible {
    var total: Double
    var remaining: Double
    var spent: Double
    
    init(total: Double, remaining: Double, spent: Double) {
        self.total = total
        self.remaining = remaining
        self.spent = spent
    }
}