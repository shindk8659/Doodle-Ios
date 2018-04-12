//
//  LoginObject.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 9..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResultObject : Mappable {
    var status : Int?
    var message : String?
    var result : LoginObject?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class LoginObject : Mappable {
    var token : String?
    var profile : LoginProfileObject?
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        profile <- map["profile"]
    }
}
class LoginProfileObject : Mappable {
    var email : String?
    var nickname : String?
    var profile : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        email <- map["email"]
        nickname <- map["nickname"]
        profile <- map["profile"]
    }
}

class ValidationVO : Mappable {
    var status : Int?
    var message : String?
    var result : ValidationResultVO?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}

class ValidationResultVO : Mappable {
    var idx : Int?
    var nickname : String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        idx <- map["idx"]
        nickname <- map["nickname"]
    }
}
