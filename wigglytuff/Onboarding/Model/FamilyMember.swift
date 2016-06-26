//
//  FamilyMember.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/25/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation

class FamilyMember {
    var firstName: String
    var lastName: String
    var birthDate: NSDate
    var memberId: String
    
    convenience init() {
        self.init(firstName: "", lastName: "", birthDate: NSDate(), memberId: "")
    }
    
    init(firstName: String, lastName: String, birthDate: NSDate, memberId: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.memberId = memberId
    }
}