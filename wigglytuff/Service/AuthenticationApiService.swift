//
//  AuthenticationApiService.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol AuthenticationApiDelegate {
    func onSuccess(newUser: Bool)
    func onError()
}

class AuthenticationApiService: ApiService {
    
    var delegate: AuthenticationApiDelegate?
    
    var firstName: String?
    var lastName: String?
    
    func performAuth(firstName: String, lastName: String, memberId: String, delegate: AuthenticationApiDelegate) {
        self.delegate = delegate
        self.firstName = firstName
        self.lastName = lastName
        
        let params: [String: AnyObject] = [
            "firstName": firstName,
            "lastName": lastName,
            "memberId": memberId
        ]
        
        httpRequestWithPath("authenticate", body: params)
    }
    
    // MARK: ApiService
    
    func handleRequestSuccess(data: JSON) {
        let newUser = data["created"].bool == nil ? false : true
        
        DataManager.sharedInstance.parse(data["user"])
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(DataManager.sharedInstance.user.firstName, forKey: "firstName")
        userDefaults.setObject(DataManager.sharedInstance.user.lastName, forKey: "lastName")
        userDefaults.setObject(DataManager.sharedInstance.user.memberId, forKey: "memberId")
        
        self.delegate?.onSuccess(newUser)
    }
    
    func handleRequestError(type: ApiErrorType, error: NSError?) {
        print(type)
        print(error!)
    }
}