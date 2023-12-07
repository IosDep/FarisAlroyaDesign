//
//  VideoFile.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import Foundation
struct VideoFile: Codable {
    let quality: String?
    let rendition: String?
    let type: String?
    let width: Int?
    let height: Int?
    let link: String?
}
