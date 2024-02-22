//
//  ServerConstants.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 14/01/2024.
//

import Foundation
class ServerConstants {
    
    static var BASE_URLـDrupal = "http://phase2.kenz-alarab.com.dedi5536.your-server.de/"
        static var BASE_URL = "https://knzalarab.com/api"


    static var BASE_URL_LIVE_STREAM = "https://api.videosdk.live/v2/"
    static var BASE_URL_LIVE_STREAM_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJhYWZhYTcxMS04MjQxLTQwM2YtYjg2OC1kODQ4NDRhODI4NDIiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcwNTE2NjM0NiwiZXhwIjoxNzIwNzE4MzQ2fQ.WLJ9qDmsCmSeHaEn51nqUhTXEV_RyGE4mSZjAQ4J-nk"

    
//    static var FlAG_ACTION = "app/flag-action"
    static var FlAG_ACTION = "/user/saveOrCancelSaveVideo"
//    saveOrCancelSaveVideo
    static var SEARCH = "/user/searchForUser"
//    static var VIDEOS = "app2/poetries"
        static var VIDEOS = "/frontend/getVideos"

    
//    static var FOLLWINGLIST = "app/following-users"
        static var MyFOLLWINGLIST = "/user/getMyFollowersFollowingData"

    
    static var UserFOLLOWEIngData = "/user/getUserFollowersFollowingData"
    
    static var UPDATEPROFILE  = "/user/updateMyProfile"
//    static var USERINFO = "app/user-info"
    
        static var USERINFO = "/user/getMyProfile"
        static var GETCOUNTRY_CODE = "/frontend/getCountryPhoneKeys"
        static var GETHASHTAG = "/frontend/getHashtags"

    static var GETALLSTREAM = "hls"
    
    static var GETNOTIFCATION = "app/notifications"
    static var STARTLIVE = "hls/start"
    static var ROOMS = "rooms"
    
    static var CATEGORY = "app/activity-list"

    static var UPLOADEVIDEO = "user/uploadVideoOrImage"
    
    static var UserLogin = "/user/login"
    static var addUser = "/user/register"
    static var likeOrDisLike = "/user/likeOrUnlikeVide"

    
    static var followOrUnfollowUser = "/user/followOrUnfollowUser"
    static var getVersionCode = "/frontend/getVersionCode"

    

}

