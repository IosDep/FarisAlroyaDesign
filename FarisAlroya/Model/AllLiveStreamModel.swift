import Foundation

struct LiveStreamResponse: Codable {
    let status: Status
    let results: LiveStreamResults
}

struct Status: Codable {
    let code: Int
    let message: String
}

struct LiveStreamResults: Codable {
//    let followingLiveStreams: [ForYouLiveStreams]
    let forYouLiveStraems: [ForYouLiveStreams]?
}

struct ForYouLiveStreams: Codable {
    let id: Int
    let user_id: Int?
    let room_id: String?
    let audience_number: Int?
    let created_at: String?
    let updated_at: String?
    let user_image : String?
    let user_name :  String?
}


struct CountryCodeKeys: Codable {
    
    let results: [CountryCodeArra]
}

struct CountryCodeArra: Codable {
    let id: Int?
    let country_phone_key: String?
}
