//
//  UserApiService.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol UserApiDelegate {
    func onSuccess()
}

class UserApiService: ApiService {
    
    var delegate: UserApiDelegate?
    
    var firstName: String?
    var lastName: String?
    
    func getUser(delegate: UserApiDelegate) {
        self.delegate = delegate
        
        let params = [String: AnyObject]()
        
        httpRequestWithPath("getUser", body: params)
    }
    
    // MARK: ApiService
    
    func handleRequestSuccess(data: JSON) {
        print(data)
        
        DataManager.sharedInstance.parse(data)
        
        self.delegate?.onSuccess()
    }
    
    func handleRequestError(type: ApiErrorType, error: NSError?) {
        print(type)
        print(error!)
    }
}