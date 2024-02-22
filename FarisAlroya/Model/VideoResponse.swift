//
//  VideoResponse.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import Foundation

struct VideoResponseData: Codable {
    var target_user: TargetUser? = nil // Assuming you have a definition for TargetUser
    let data: [VideoResponse]
    var pagination :Pagination? = nil
}

struct VideoResponse: Codable {
        let id: Int?
        let title: String?
        let created_at: String?
        
        let token: String?
        let moderation_state: String?
        let vimeo_detials: VimeoDetails?
        let auther: Author?
        let video_actions_per_user:Video_actions_per_user?
        let video_counts:VideoCounts?
}

struct TargetUser: Codable {
    let target_user_follow_flag: Int?

    
}


struct VideoCounts:Codable{
    var like_count: String?
        var  save_count: String?
    var favorites_count  :String?
}


struct Video_actions_per_user:Codable{
    var save: Bool?
        var  like: Bool?
}
