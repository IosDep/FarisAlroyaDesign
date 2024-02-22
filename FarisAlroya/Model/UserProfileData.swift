//
//  UserProfileData.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 15/01/2024.
//

import Foundation
struct UserProfileData: Codable {
    let results: UserProfileDataArray?
    let msg: MsgModel?
    

}
struct MsgModel: Codable {
    let message:String?
    var status: Int?

}

struct UserProfileDataArray: Codable {
    let id: Int?
    let user_name: String?
    let profile_image: String?
    let email: String?
    let phone: String?
    let profile_data: ProfileData?
    let auther: AutherProfile?
    
    let likes_count: String?
    let number_of_comments: String?
    let number_of_save: String?
    
    let following_count: String?
    let followers_count: String?

    
    
    let first_name: String?

    let last_name: String?

    let date_of_birth: String?

    let live_status: String?
    let sex: String?

    
    
}


struct AutherProfile: Codable {
    
    let numOfFollowers: Int?
    let numOfFollowing: Int?
    let numOfLikes: Int?

}
