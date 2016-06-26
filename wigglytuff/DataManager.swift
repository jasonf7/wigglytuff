//
//  DataManager.swift
//  wigglytuff
//
//  Created by Jason Fang on 6/26/16.
//  Copyright © 2016 Jason Fang. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager {
    static let sharedInstance = DataManager()
    
    var user: User!
    var plan: Plan!
    var provider: Provider!
    var coverage: [String: [String: Coverage]]!
    var familyCoverage: [String: [String: Coverage]]!
    var family: FamilyMember!
    
    var categories: [String]!
    
    var searchKeywords: [String: Set<String>]?
    
    var gotData = false
    
    func parse(data: JSON) {
        self.user = User(firstName: data["firstName"].stringValue, lastName: data["lastName"].stringValue, memberId: data["memberId"].stringValue)
        
        self.plan = Plan(number: data["plan"]["number"].stringValue, description: data["plan"]["description"].stringValue)
        
        self.provider = Provider(name: data["provider"]["name"].stringValue, phoneNumber: data["provider"]["phone"].stringValue, address: data["provider"]["location"]["address"].stringValue, city: data["provider"]["location"]["city"].stringValue, state: data["provider"]["location"]["state"].stringValue, zipCode: data["provider"]["location"]["zipcode"].stringValue)
        
        self.coverage = parseCoverageDict(data)
            
        // Optional:
        self.categories = [String]()
        if let categoryArr = data["categoriesToDisplay"].array {
            for json in categoryArr {
                self.categories.append(json.stringValue)
            }
        }
        
        if let familyDict = data["family"].dictionary {
            print("PARSE FAMILY")
            self.familyCoverage = parseCoverageDict(familyDict["W000000000"]!)
        }
        
        self.gotData = true
    }
    
    func parseCoverageDict(data: JSON) -> [String: [String: Coverage]] {
        var returnVal = [String: [String: Coverage]]()
        
        for (category, json) in data["categories"].dictionaryValue {
            var temp = [String: Coverage]()
            
            for (service, coverage) in json.dictionaryValue {
                temp[service] = Coverage(
                    deductible: Deductible(
                        total: coverage["deductible"]["total"].doubleValue,
                        remaining: coverage["deductible"]["remaining"].doubleValue,
                        spent: coverage["deductible"]["spent"].doubleValue
                    ),
                    coinsurance: coverage["coinsurancePercent"].doubleValue,
                    copay: coverage["copay"]["amount"].doubleValue)
            }
            
            returnVal[category] = temp
        }
        
        return returnVal
    }
    
    func parseSearchKeywords(data: JSON) {
        var searchData = [String: Set<String>]()
        for (service, keywordArr) in data.dictionaryValue {
            var keywords = Set<String>()
            for keywordJson in keywordArr["keywords"].arrayValue {
                keywords.insert(keywordJson.stringValue)
            }
            searchData[service] = keywords
        }
        self.searchKeywords = searchData
    }
}