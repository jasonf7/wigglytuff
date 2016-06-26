//
//  FamilyMemberApiService.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias FamilyMemberApiDelegate = () -> Void

class FamilyMemberApiService: ApiService {
    
    var delegate: FamilyMemberApiDelegate?
    
    var firstName: String?
    var lastName: String?
    
    func addFamilyMembers(familyMembers: [FamilyMember], delegate: FamilyMemberApiDelegate) {
        self.delegate = delegate
        
        let params: [String: AnyObject] = [
            "family": [
                "firstName": familyMembers[0].firstName,
                "lastName": familyMembers[0].lastName,
                "memberId": familyMembers[0].memberId,
            ]
        ]
        
        httpRequestWithPath("user/family", body: params)
    }
    
    // MARK: ApiService
    
    func handleRequestSuccess(data: JSON) {
        self.delegate?()
    }
    
    func handleRequestError(type: ApiErrorType, error: NSError?) {
        print(type)
        print(error!)
    }
}