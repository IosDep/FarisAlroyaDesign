//
//  AuthForms.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 09/01/2024.
//

import Foundation

struct LoginBody: Codable{
    var user_name: String
    var password: String
}

struct RegisterBody: Codable {
    var first_name: String
    var last_name: String
    var user_name: String
    var date_of_birth: String
    var password: String
    var phone: String
    var email: String
    var sex: Int
    var hashtags_ids: [Int]
    var country_phone_id: Int
}

struct Hashtags: Codable {
    var id: Int?
    var hashtag: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case hashtag = "hashtag"
    }
}

struct CountryCode: Codable {
    var id: Int?
    var countryCode: String?

    static func == (lhs: CountryCode, rhs: CountryCode) -> Bool {
          return lhs.id == rhs.id && lhs.countryCode == rhs.countryCode
      }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case countryCode = "country_phone_key"
    }
}
