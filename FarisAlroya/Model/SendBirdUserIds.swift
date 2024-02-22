//
//  SendBirdUserIds.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 22/01/2024.
//

import Foundation
import Foundation

// Define structures to match the JSON response
struct UserResponse: Codable {
    let users: [User]
    var  next :  String?
}

struct User: Codable {
    let userId: String

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}
