//
//  LiveStreamModel.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 16/01/2024.
//

import Foundation
struct LiveStreamModel: Codable {
    let data: [LiveStreamModelArray]?

    
}


struct LiveStreamModelArray: Codable {
    
    let roomId: String?
    let downstreamUrl: String?
    
    let livestreamUrl: String?

    
}
