struct UserProfile {
    var uid, role, mail, username, user_picture, phone_number, first_name, last_name, band_name: String?
    var profile_data: [String: Any]

    init(data: [String: Any]) {
        self.uid = data["uid"] as? String
        self.role = data["role"] as? String
        self.mail = data["mail"] as? String
        self.username = data["username"] as? String
        self.user_picture = data["user_picture"] as? String
        self.phone_number = data["phone_number"] as? String

        if let profileData = data["profile_data"] as? [String: Any] {
            self.band_name = profileData["band_name"] as? String
            self.first_name = profileData["first_name"] as? String
            self.last_name = profileData["last_name"] as? String
        }
        
        self.profile_data = data["profile_data"] as? [String: Any] ?? [:]
        
    }
}
