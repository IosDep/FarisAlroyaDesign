//
//  VideoResponse.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import Foundation
struct VideoResponse: Codable {
    let id: String?
    let title: String?
    let created: String?
    let file: String?
    let uuid: String?
    let token: String?
    let moderation_state: String?
    let vimeo_detials: VimeoDetails?
    let auther: Author?
}
