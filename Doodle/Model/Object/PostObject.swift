//
//  PostObject.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 9..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class PostObject : Mappable {
    var status : Int?
    var message : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map[""]
        message <- map["message"]
    }
}


