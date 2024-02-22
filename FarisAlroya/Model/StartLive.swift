//
//  StartLive.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 16/01/2024.
//

import Foundation
struct RoomRequest: Codable {
    let region: String
    
    let webhook: Webhook
}

struct Webhook: Codable {
    let endPoint: String
    let events: [String]
}

struct RoomResponse: Codable {
    let apiKey: String
    let webhook: WebhookResponse
    let disabled: Bool
    let autoCloseConfig: AutoCloseConfig
    let createdAt: String
    let updatedAt: String
    let roomId: String
    let links: Links
    let id: String

    struct WebhookResponse: Codable {
        let endPoint: String
        let events: [String]
    }

    struct AutoCloseConfig: Codable {
        let type: String
    }

    struct Links: Codable {
        let getRoom: String
        let getSession: String

        enum CodingKeys: String, CodingKey {
            case getRoom = "get_room"
            case getSession = "get_session"
        }
    }
}

