//
//  Author.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import Foundation
struct Author: Codable {
    let uid: String?
    let username: String?
    let type: String?
    let profile_data: ProfileData?
}
struct ProfileData: Codable {
    let first_name: String?
    let last_name: String?
    let user_picture: String?
    let band_name: String?
    let mail: String?


}
