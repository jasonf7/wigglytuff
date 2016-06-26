//
//  User.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation

class User {
    var firstName: String
    var lastName: String
    var memberId: String
    
    init(firstName: String, lastName: String, memberId: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.memberId = memberId
    }
}