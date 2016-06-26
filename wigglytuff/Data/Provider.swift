//
//  Provider.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation

class Provider {
    var name: String
    var phoneNumber: String
    var address: String
    var city: String
    var state: String
    var zipcode: String
    
    init(name: String, phoneNumber: String, address: String, city: String, state: String, zipCode: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.address = address
        self.city = city
        self.state = state
        self.zipcode = zipCode
    }
}