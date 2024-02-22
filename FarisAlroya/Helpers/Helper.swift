import Foundation
import Security


final class Helper {
    
    static let shared = Helper()

    
    func saveId(id:String)
    {
        let def = UserDefaults.standard
        def.setValue(id, forKey: "id")
        def.synchronize()
    }
    
    
    func getId()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "id" ) as? String
    }
  
    
    func saveNewId(id:Int)
    {
        let def = UserDefaults.standard
        def.setValue(id, forKey: "uid")
        def.synchronize()
    }
    
    
    func getNewId()-> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "uid" ) as? Int
    }
  
    
    func saveRole(role:String)
    {
        let def = UserDefaults.standard
        def.setValue(role, forKey: "role")
        def.synchronize()
    }
    
    
    func getRole()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "role" ) as? String
    }
    
    
    
    
    func saveUsername(user_name:String)
    {
        let def = UserDefaults.standard
        def.setValue(user_name, forKey: "user_name")
        def.synchronize()
    }
    
    
    func getUsername()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "user_name" ) as? String
    }
    
    
    func saveEmail(email:String)
    {
        let def = UserDefaults.standard
        def.setValue(email, forKey: "email")
        def.synchronize()
    }
    
    
    func getEmail()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "email" ) as? String
    }
    
    
    
    func savePhone(phone_number:String)
    {
        let def = UserDefaults.standard
        def.setValue(phone_number, forKey: "phone_number")
        def.synchronize()
    }
    
    
    func getPhone()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "phone_number" ) as? String
    }
    
    
    func saveUser_picture(user_picture:String)
    {
        let def = UserDefaults.standard
        def.setValue(user_picture, forKey: "user_picture")
        def.synchronize()
    }
    
    
    func getUser_picture()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "user_picture" ) as? String
    }
    
    
    
    
    
    func saveUserToken(user_picture:String)
    {
        let def = UserDefaults.standard
        def.setValue(user_picture, forKey: "token")
        def.synchronize()
    }
    
    
    func getUserToken()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "token" ) as? String
    }
    func saveUserTokenfForGuest(user_picture:String)
    {
        let def = UserDefaults.standard
        def.setValue(user_picture, forKey: "tokeng")
        def.synchronize()
    }
    
    
    func getUserTokenForGuest()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "tokeng" ) as? String
    }
}

