//
//  Coverage.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation

class Coverage {
    var coinsurance: Double
    var copay: Double
    var deductible: Deductible
    
    init(deductible: Deductible, coinsurance: Double, copay: Double) {
        self.deductible = deductible
        self.coinsurance = coinsurance
        self.copay = copay
    }
}