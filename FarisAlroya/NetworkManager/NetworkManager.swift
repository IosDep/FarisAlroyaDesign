import Alamofire
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()

    func fetchVideos(uid: String, state: String, pageSize: Int,page:Int, completion: @escaping (Result<[NewAppendItItems], Error>) -> Void) {
        let urlString = "http://kenz-alarab.com.dedi5536.your-server.de/app2/poetries"
        let parameters: Parameters = [
            "uid": uid,
            "state": state,

            "page_limit": pageSize,
            
        ]
        print("Request URL: \(urlString)")
        print("Parameters: \(parameters)")


        AF.request(urlString, method: .get,parameters: parameters).responseDecodable(of: [VideoResponse].self) { response in
            print("ERTYUIO",response.result)
            switch response.result {
            case .success(let videoResponse):
                let newItems = videoResponse.map { item -> NewAppendItItems in
                    let vidLink = item.vimeo_detials?.files?.first(where: { $0.rendition == "adaptive" || $0.rendition == "360" })?.link ?? item.file
                    print("WERTYUIODFGHJ",item)

                    return NewAppendItItems(videoTitle: item.title ?? "", videoDesc: item.id!, date: item.created ?? "", videoUrl: vidLink ?? "", userId: item.auther?.uid ?? "", userName: item.auther?.username ?? "", duration: item.vimeo_detials?.duration ?? 0, imageThum: item.vimeo_detials?.pictures?.base_link ?? "",firstName: item.auther?.profile_data?.first_name ?? "",lastName: item.auther?.profile_data?.last_name ?? "",bandNam: item.auther?.profile_data?.band_name ?? "" , type:  item.moderation_state ?? "" ,userPic: item.auther?.profile_data?.user_picture ?? "",isPlaying: false)
                }
                
                completion(.success(newItems))

            case .failure(let error):
                completion(.failure(error))
                print("Network request failed: \(error)")

            }
        }
    }
    
    
    
//    func getUserInfo(uid : String , completion: @escaping (Result<[UserProfile], Error>) -> Void) {
//        let urlString = ""
//
//
////        let parameters: Parameters = [
////            "uid": uid
////
////        ]
////
//
//        AF.request(urlString, method: .get).responseDecodable(of: [UserProfile].self) { response in
//            print("ERTYUIO",response.result)
//            switch response.result {
//            case .success(let userProfile):
//
//               //
//
//                }
//
//                completion(.success(newItems))
//
//            case .failure(let error):
//                completion(.failure(error))
//                print("Network request failed: \(error)")
//
//            }
//        }
//    }
    
    
   
}
