//
//  DailyBackground.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 10..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class DailyBackground : Mappable {
    var status : Int?
    var message : String?
    var result : [DailyBackgroundResult]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class DailyBackgroundResult : Mappable{
    
    var image : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        
    }
}


