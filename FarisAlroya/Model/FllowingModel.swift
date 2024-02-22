//
//  FllowingModel.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 15/01/2024.
//

import Foundation
struct FllowingModel: Codable {
 
    var results:ResultsFollow?
    let msg: MsgModel?
    let status: Int?
    
}
struct ResultsFollow: Codable {
    var followers: [FllowingModelArray]?
    var following: [FllowingModelArray]?
}
struct FllowingModelArray: Codable {
    let id : Int?
     let user_name: String?
     let profile_image: String?
     let is_following: Bool?
}
struct FllowerModelArray: Codable {
    let id : Int?
     let user_name: String?
     let profile_image: String?
     let is_following: Bool?
}
//struct FllowingModelArray: Codable {
//    let uid : String?
//    let user_name: String?
//    let picture: String?
//    let flag: Int?
//
//}
