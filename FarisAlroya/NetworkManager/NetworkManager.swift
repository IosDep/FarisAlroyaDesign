import Alamofire
import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func fetchVideos(uid: String, isHome:String,state: String, pageSize: Int, page: Int, completion: @escaping (Result<VideoResponseData, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL  +  ServerConstants.VIDEOS
        var parameters: [String:Any]?
    
        if state == "0" {
            parameters = [
                
                "Page_limit": pageSize,
                "page" : page,
                "Is_home"  : "0",

                "token": Helper.shared.getUserToken() ?? "",


            ]
        }else if state == "1"{
            parameters = [
                
                
                "Page_limit": pageSize,
                "page" : page,
                "Is_home"  : "0",
                "token": Helper.shared.getUserToken() ?? "",
                "User_profile_uid" :uid

            ]
        }else if state == "2"{
            parameters = [
                
                "Page_limit": pageSize,
                "page" : page,
                "Is_home"  : "1",

                "token": Helper.shared.getUserToken() ?? "",
                "isSaved" :  1

            ]
        }
        
        else {
            parameters = [
                
                "Page_limit": pageSize,
                "page" : page,
                "Is_home"  : "1",

                "token": Helper.shared.getUserToken() ?? "",


            ]
        }
    
        
        print("ERTYUIO",urlString)
        print("ERTYUI123O",parameters)

        AF.request(urlString, method: .get, parameters: parameters).responseDecodable(of: VideoResponseData.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
                print("ERTYUIO",error.localizedDescription)
                print("ERTYUI2",error)

                
            }
        }
    }
    
    
    
    
    func fetchSaveVideos(uid: String, isHome:String,state: String, pageSize: Int, page: Int, completion: @escaping (Result<VideoResponseData, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL  + "/user/getMySavedVideos"
        var parameters: [String:Any]?
    
        
//            parameters = [
//
//                "Page_limit": pageSize,
//                "page" : page,
//
//
//                "token": Helper.shared.getUserToken() ?? "",
//
//
//            ]
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
              
          ]
        
        
        print("ERTYUIO",urlString)
        print("ERTYUI123O",parameters)

        AF.request(urlString, method: .post, parameters: parameters,headers:headers ).responseDecodable(of: VideoResponseData.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
                print("ERTYUIO",error.localizedDescription)
                print("ERTYUI2",error)

                
            }
        }
    }
    
    func fetchCountryCode( completion: @escaping (Result<[CountryCode], Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL   + ServerConstants.GETCOUNTRY_CODE



        AF.request(urlString, method: .post).responseDecodable(of: [CountryCode].self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

    func fetchHashTag( completion: @escaping (Result<[CountryCode], Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL   + ServerConstants.GETHASHTAG



        AF.request(urlString, method: .post).responseDecodable(of: [CountryCode].self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchSearchUsers(uid: String, search_key: String, completion: @escaping (Result<SearchModel, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL   + ServerConstants.SEARCH
        let parameters: Parameters = [
            
            "text": search_key
            
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
              
          ]
        AF.request(urlString, method: .post, parameters: parameters,headers: headers).responseDecodable(of: SearchModel.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func followOrUnfollowUser(follower_id: String, completion: @escaping (Result<MsgModel, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL   + ServerConstants.followOrUnfollowUser
        let parameters: [String:Any] = [
            "follower_id": follower_id,
            "lang": "ar"


        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
              
          ]

        AF.request(urlString, method: .post, parameters: parameters,headers: headers).responseDecodable(of: MsgModel.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchUserFollowingUsers(target_uid:String, completion: @escaping (Result<FllowingModel, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL +  ServerConstants.UserFOLLOWEIngData
        let parameters: [String:Any] = [
            "user_id":target_uid
      

        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
          ]
        print("TOKKKENS",Helper.shared.getUserToken()  ?? "")


        AF.request(urlString, method: .post, parameters: parameters,headers: headers).responseDecodable(of: FllowingModel.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllLiveStream(completion: @escaping (Result<LiveStreamResponse, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL + "/user/getAllLiveStreams"
//        let parameters: [String:Any] = [
//            "user_id":target_uid
//
//
//        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
          ]
        print("TOKKKENS",Helper.shared.getUserToken()  ?? "")


        AF.request(urlString, method: .post,headers: headers).responseDecodable(of: LiveStreamResponse.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getCountryKeys(completion: @escaping (Result<CountryCodeKeys, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL + "/frontend/getCountryPhoneKeys"
//        let parameters: [String:Any] = [
//            "user_id":target_uid
//
//
//        ]
      
        print("TOKKKENS",Helper.shared.getUserToken()  ?? "")


        AF.request(urlString, method: .post).responseDecodable(of: CountryCodeKeys.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
                
                print(responseData)
            case .failure(let error):
                print("ERRRR/:",error.localizedDescription)
                print("ERRRR2/:",error.localizedDescription)

                completion(.failure(error))
            }
        }
    }
    
    
//    
    func fetchMYFollowerUsers( completion: @escaping (Result<FllowingModel, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL   +  ServerConstants.MyFOLLWINGLIST
//        let parameters: Parameters = [
//            "user_id": uid,
//
//
//            "lang": "ar"
//        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
              
          ]


        AF.request(urlString, method: .post,headers: headers).responseDecodable(of: FllowingModel.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchUserProfile(uid: String, completion: @escaping (Result<UserProfileData, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL   + ServerConstants.USERINFO
        let parameters: [String:Any] = [
            "uid": uid

        ]
//        "lang": "ar"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
              
          ]

        AF.request(urlString, method: .post,headers: headers).responseDecodable(of: UserProfileData.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    
    func fetchLiveStream(page: String,perPage:String, completion: @escaping (Result<LiveStreamModel, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL_LIVE_STREAM   + ServerConstants.GETALLSTREAM
        let parameters: Parameters = [
            "page": 0,
            "perPage": 3

        ]
//        "lang": "ar"
        let headers: HTTPHeaders = [
            "Authorization": ServerConstants.BASE_URL_LIVE_STREAM_TOKEN, // Replace YOUR_ACCESS_TOKEN with your actual token
            "Accept": "application/json"
        ]

        AF.request(urlString, method: .get, parameters: parameters,headers: headers).responseDecodable(of: LiveStreamModel.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func fetchNotifcation(uid:String, completion: @escaping (Result<NotifcationModel, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URLـDrupal   + ServerConstants.GETNOTIFCATION
        let parameters: Parameters = [
            "uid": uid,
   

        ]


        AF.request(urlString, method: .post, parameters: parameters).responseDecodable(of: NotifcationModel.self) { response in
            switch response.result {
            case .success(let responseData):
                completion(.success(responseData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    func createRoom(requestData: RoomRequest, token: String, completion: @escaping (Result<RoomResponse, Error>) -> Void) {
        let urlString = ServerConstants.BASE_URL_LIVE_STREAM +  ServerConstants.ROOMS // Replace with your actual URL
           let headers: HTTPHeaders = [
            "Authorization": ServerConstants.BASE_URL_LIVE_STREAM_TOKEN,
               
           ]
           
           AF.request(urlString, method: .post, parameters: requestData, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: RoomResponse.self) { response in
               switch response.result {
               case .success(let roomResponse):
                   completion(.success(roomResponse))
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
    
    
}
