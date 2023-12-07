//
//  NewAppendItItems.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import Foundation


struct NewAppendItItems: Codable {
    let videoTitle: String
    let videoDesc: String
    let date: String
    let videoUrl: String
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


    // Default values in Swift are typically handled in initializers
    init(videoTitle: String, videoDesc: String, date: String, videoUrl: String, userId: String, userName: String, duration: Int, imageThum: String = "", firstName: String , lastName: String, bandNam: String, type: String  , userPic: String , status: String = "",isPlaying: Bool) {
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
    }
}
