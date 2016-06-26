//
//  CategoryApiService.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias CategoryApiDelegate = () -> Void

class CategoryApiService: ApiService {
    
    var delegate: CategoryApiDelegate?
    
    var firstName: String?
    var lastName: String?
    
    func addCategories(categories: [String], delegate: CategoryApiDelegate) {
        self.delegate = delegate
        
        let params: [String: AnyObject] = [
            "categories": categories
        ]
        
        httpRequestWithPath("user/categoriesToDisplay", body: params)
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
