//
//  ApiService.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation

import SwiftyJSON

enum ApiErrorType {
    case JSON_SERIALIZATION
    case SERVER
    case EMPTY_BODY
}

protocol ApiService {
    func handleRequestSuccess(data: JSON)
    func handleRequestError(type: ApiErrorType, error: NSError?)
}

extension ApiService {
    
    var baseUrl: String {
        return "http://localhost:9000/api/"
    }
    
    func httpRequestWithPath(path: String, body: [String: AnyObject]) {
        let finalUrl = baseUrl.stringByAppendingString(path)
        
        let request = NSMutableURLRequest(URL: NSURL(string: finalUrl)!)
        
        var newBody = body
        if DataManager.sharedInstance.gotData {
            newBody["firstName"] = DataManager.sharedInstance.user.firstName
            newBody["lastName"] = DataManager.sharedInstance.user.lastName
            newBody["memberId"] = DataManager.sharedInstance.user.memberId
        }
        
        do {
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let bodyData = try NSJSONSerialization.dataWithJSONObject(newBody, options: NSJSONWritingOptions.PrettyPrinted)
            
            request.HTTPBody = bodyData
            request.setValue(String(bodyData.length), forHTTPHeaderField: "Content-Length")
        } catch {
            self.handleRequestError(ApiErrorType.JSON_SERIALIZATION, error: nil)
            return
        }
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data: NSData?, resp: NSURLResponse?, err: NSError?) -> Void in
            if let error = err {
                self.handleRequestError(ApiErrorType.SERVER, error: error)
            } else if let jsonData = data {
                let json = JSON(data: jsonData)
                self.handleRequestSuccess(json)
            } else {
                self.handleRequestError(ApiErrorType.EMPTY_BODY, error: nil)
            }
        })
        
        task.resume()
    }
    
}