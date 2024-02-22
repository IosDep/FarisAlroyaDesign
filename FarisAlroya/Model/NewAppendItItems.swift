//
//  NewAppendItItems.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import Foundation



struct Pagination: Codable {
    var last_page:Int
}

struct NewAppendItItems: Codable {
let videoTitle: String
let videoDesc: String
let date: String
let videoUrl: String?
let userId: String
let userName: String
let duration: Int
let imageThum: String
let firstName: String
let lastName: String
let bandNam: String
let type: String
let userPic: String
let status: String
var isPlaying: Bool = false

var userFav : Bool = false
var userSave : Bool = false
var numofVideoLike: String = ""
var numOfFollowers: String = ""
var numOfFollowing: String = ""
var numOfLikes: String =  ""
var nodeId:String = ""
var target_user_follow_flag  = 0
//var lastPage  = 0


    // Default values in Swift are typically handled in initializers
    init(videoTitle: String, videoDesc: String, date: String, videoUrl: String, userId: String, userName: String, duration: Int, imageThum: String = "", firstName: String , lastName: String, bandNam: String, type: String  , userPic: String , status: String = "",isPlaying: Bool    , userFav : Bool ,
         userSave : Bool ,
         numofVideoLike:String,
        numOfFollowers: String,
         numOfFollowing: String,
         numOfLikes: String ,
         nodeId:String,
         target_user_follow_flag :Int
    ) {
        self.videoTitle = videoTitle
        self.videoDesc = videoDesc
        self.date = date
        self.videoUrl = videoUrl
        self.userId = userId
        self.userName = userName
        self.duration = duration
        self.imageThum = imageThum
        self.firstName = firstName
        self.lastName = lastName
        self.bandNam = bandNam
        self.type = type
        self.userPic = userPic
        self.status = status
        self.isPlaying = isPlaying
        
        self.userFav = userFav
        self.numofVideoLike = numofVideoLike
        self.numOfFollowers = numOfFollowers
        self.numOfFollowing = numOfFollowing
        self.numOfLikes = numOfLikes
        self.nodeId = nodeId
        self.target_user_follow_flag = target_user_follow_flag
//        self.lastPage = lastPager
    }
}

