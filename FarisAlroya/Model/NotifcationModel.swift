//
//  NotifcationModel.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 16/01/2024.
//

import Foundation

struct NotifcationModel: Codable {
    let data: [NotifcationModelArray]?
    let message: String?
    let status: Int?
    
}

struct NotifcationModelArray: Codable {
    let body: String?
    let title: String?
    
    
}
