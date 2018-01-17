//
//  Profile.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 8..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class Profile: Mappable {
    var status: Int?
    var message: String?
    var result: ProfileList?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class ProfileList : Mappable{
    var idx : Int?
    var nickname: String?
    var description: String?
    var doodle_count: Int?
    var scrap_count: Int?
    var image: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        idx <- map["idx"]
        nickname <- map["nickname"]
        description <- map["description"]
        doodle_count <- map["doodle_count"]
        scrap_count <- map["scrap_count"]
        image <- map["image"]
    }
}

