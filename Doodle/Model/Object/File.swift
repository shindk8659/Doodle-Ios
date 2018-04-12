//
//  File.swift
//  Doodle
//
//  Created by seunghwan Lee on 2018. 1. 9..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class DailyBackgroundImg : Mappable {
    var status : Int?
    var message : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map[""]
        message <- map["message"]
    }
}



