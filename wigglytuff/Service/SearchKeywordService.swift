//
//  SearchKeywordService.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol SearchKeywordApiDelegate {
    func onSuccess()
}

class SearchKeywordApiService: ApiService {
    
    var delegate: SearchKeywordApiDelegate?
    
    func getSearchKeywords(delegate: SearchKeywordApiDelegate) {
        self.delegate = delegate
        
        let params = [String: AnyObject]()
        
        httpRequestWithPath("service/types", body: params)
    }
    
    // MARK: ApiService
    
    func handleRequestSuccess(data: JSON) {
        DataManager.sharedInstance.parseSearchKeywords(data)
        
        self.delegate?.onSuccess()
    }
    
    func handleRequestError(type: ApiErrorType, error: NSError?) {
        print(type)
        print(error!)
    }
}