//
//  VimeoDetails.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import Foundation
struct VimeoDetails: Codable {
    let uri: String?
    let name: String?
    let description: String?
    let type: String?
    let link: String?
    let player_embed_url: String?
    let duration: Int?
    let width: Int?
    let language: String?
    let height: Int?
    let files: [VideoFile]?
    let pictures: Pictures?
}
