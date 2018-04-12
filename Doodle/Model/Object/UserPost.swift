//
//  MyPost.swift
//  Doodle
//
//  Created by 신동규 on 2018. 1. 7..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import ObjectMapper

class UserPost: Mappable {
    
    var status: Int?
    var message: String?
    var result: UserPostResult?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        result <- map["result"]
    }
}
class UserPostResult :Mappable{
    
    var user : UserPostInfo?
    var doodle : [UserPostList]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        doodle <- map["doodle"]
        
    }
    
    
}
class UserPostInfo :Mappable{
    
    var nickname: String?
    var profile: String?
    var description: String?
    var scrap_count: Int?
    var doodle_count: Int?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        nickname <- map["nickname"]
        profile <- map["profile"]
        description <- map["description"]
        scrap_count <- map["scrap_count"]
        doodle_count <- map["doodle_count"]
        
    }
    
}
class UserPostList : Mappable{
    
    
    
    var idx: Int?
    var created: String?
    var scrap_count: Int?
    var comment_count : Int?
    var like_count: Int?
    var image: String?
    var scraps:Int?
    var user_idx: Int?
    var like: Int?
    var scrap: Int?
    var nickname: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        idx <- map["idx"]
        created <- map["created"]
        scrap_count <- map["scrap_count"]
        comment_count <- map["comment_count"]
        like_count <- map["like_count"]
        image <- map["image"]
        scraps <- map["scraps"]
        user_idx <- map["user_idx"]
        scrap <- map["scraps"]
        nickname <- map["nickname"]
    }
}




