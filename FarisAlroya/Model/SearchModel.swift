//
//  SearchModel.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 15/01/2024.
//

import Foundation
struct SearchModel: Codable {
    let results: [SearchModelArray]?
    let message: String?
    let status: Int?
    
}
struct SearchModelArray: Codable {
    
    let id: Int?
    let user_name: String?
    let profile_image: String?
    let phone: String?
    let email: String?

    let userFollowings: String?
    let userFollowers: String?
    let userVideosLikes: String?

    let isFollowing : Int?


    

}



struct ProfileDataSearch: Codable {
    let first_name: String?
    let last_name: String?

    
}

struct FollowerChecker: Codable {
    
    let numOfFollowers: Int?
    let numOfFollowing: Int?
    let numOfLikes: Int?

    
}

struct AutherSearch: Codable {
    
    
    
    let isfollower: Int?
    let isfollowing: Int?
}
