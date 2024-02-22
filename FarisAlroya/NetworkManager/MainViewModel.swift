

import Foundation
import Alamofire

class MainViewModel {
    var videos: [NewAppendItItems] = []
    var searchData: [SearchModelArray] = []
    
    var allLiveStream: [ForYouLiveStreams] = []
    var countryCodeArr: [CountryCodeArra] = []

    var follwList: FllowingModel?
    var profileList: UserProfileData?
    var createRoomRespobnse:RoomResponse? = nil
    
    
    var msgModel:MsgModel? = nil

    var liveStramArray: [LiveStreamModelArray] = []
    var notifcaitonArray: [NotifcationModelArray] = []

    var currentPage = 5
    var hasMoreData = true
    var isLoading = false
    var hasMoreData2 = true
    var isLoading2 = false
    func getMainVideos(uid: String,isHome:String,state: String, pageSize: Int, page: Int, completion: @escaping ([NewAppendItItems], Error?) -> Void) {
        guard !isLoading && hasMoreData else {
            completion([], nil)
            return
        }

        isLoading = true

        NetworkManager.shared.fetchVideos(uid: uid, isHome: isHome
                                          , state: state, pageSize: pageSize, page: page) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let videoResponseData):
                    guard let strongSelf = self else {
                        completion([], nil) // If self is nil, return an empty array
                        return
                    }
                    let newVideos = videoResponseData.data.compactMap { strongSelf.transformToNewAppendItItems(from: $0, targetUser: videoResponseData.target_user,pagention: videoResponseData.pagination!) }
                    print("adlksd",videoResponseData.target_user)
                    if newVideos.isEmpty {
                        strongSelf.hasMoreData = false
                    } else {
                        strongSelf.videos.append(contentsOf: newVideos)
                    }
                    strongSelf.currentPage += 1
                    completion(newVideos, nil) // Only return new videos

                case .failure(let error):
                    print("Error fetching videos: \(error.localizedDescription)")
                    completion([], error)
                }
            }
        }
    }
    

    func getSavedVideos(uid: String,isHome:String,state: String, pageSize: Int, page: Int, completion: @escaping ([NewAppendItItems], Error?) -> Void) {
     
        
        guard !isLoading && hasMoreData else {
            completion([], nil)
            return
        }

        isLoading = true

        NetworkManager.shared.fetchVideos(uid: uid, isHome: isHome
                                          , state: state, pageSize: pageSize, page: page) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let videoResponseData):
                    guard let strongSelf = self else {
                        completion([], nil) // If self is nil, return an empty array
                        return
                    }
                    let newVideos = videoResponseData.data.compactMap { strongSelf.transformToNewAppendItItems(from: $0, targetUser: videoResponseData.target_user,pagention: videoResponseData.pagination!) }
                    print("adlksd",videoResponseData.target_user)
                    if newVideos.isEmpty {
                        strongSelf.hasMoreData = false
                    } else {
                        strongSelf.videos.append(contentsOf: newVideos)
                    }
                    strongSelf.currentPage += 1
                    completion(newVideos, nil) // Only return new videos

                case .failure(let error):
                    print("Error fetching videos: \(error.localizedDescription)")
                    completion([], error)
                }
            }
        }
    }

    private func processVideoResponseData(_ videoResponseData: [VideoResponse],_ targetUser:TargetUser?,pagention:Pagination?, completion: ([NewAppendItItems], Error?) -> Void) {
        let newVideos = videoResponseData.map { self.transformToNewAppendItItems(from: $0,targetUser: targetUser,pagention:pagention!) }
        
        if newVideos.isEmpty {
            self.hasMoreData = false
            self.hasMoreData2 = false

            completion([], nil) // No more data
        } else {
            self.hasMoreData = true
            self.hasMoreData2 = true

            self.videos.append(contentsOf: newVideos)
            self.currentPage   = self.currentPage  + 1 // Update the current page
            print(newVideos)
            print(currentPage,"PPPPAGe")
            completion(self.videos, nil)
        }
    }
    
    
    
    private func transformToNewAppendItItems(from item: VideoResponse,targetUser:TargetUser?,pagention:Pagination) -> NewAppendItItems {
        
        let vidLink = item.vimeo_detials?.files?.first(where: { $0.rendition == "adaptive" || $0.rendition == "360" })?.link ?? item.vimeo_detials?.files?.first?.link ?? ""
        
        return NewAppendItItems(
            videoTitle: item.title ?? "",
            videoDesc: "\(item.id ?? 0)",
            date: item.created_at ?? "",
            videoUrl: item.vimeo_detials?.files?.first?.link ?? "",
            userId: "\(item.auther?.uid ?? 0)",
            userName: item.auther?.username ?? "",
            duration: item.vimeo_detials?.duration ?? 0,
            imageThum: item.vimeo_detials?.pictures?.base_link ?? "",
            firstName: item.auther?.profile_data?.first_name ?? "",
            lastName: item.auther?.profile_data?.last_name ?? "",
            bandNam: item.auther?.profile_data?.band_name ?? "",
            type: item.moderation_state ?? "",
            userPic: item.auther?.profile_data?.user_picture ?? "",
            isPlaying: false,
            userFav : item.video_actions_per_user?.like ?? false,
            userSave: item.video_actions_per_user?.save ?? false,
            numofVideoLike:"\( item.video_counts?.like_count ?? "")",
            numOfFollowers:item.auther?.numOfFollowers ?? "0" ,
            numOfFollowing:item.auther?.numOfFollowing  ?? "0",
            numOfLikes:item.auther?.numOfLikes ?? "0",
            nodeId:"\(item.id ?? 0)",
            target_user_follow_flag: targetUser?.target_user_follow_flag  ?? 0
            
            
            
            
        )

    }
    //    private func appendNewVideos(from videoResponses: [VideoResponse]) {
    //          let newVideos = videoResponses.map { transformToNewAppendItItems(from: $0) }
    //          self.videos.append(contentsOf: newVideos)
    //      }
    
    
    
//    Search Api
    
    

    func searchUsers(searchKey: String, completion: @escaping (Bool, Error?) -> Void) {
           NetworkManager.shared.fetchSearchUsers(uid: Helper.shared.getId() ?? "", search_key: searchKey) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let searchResponseData):
                       self?.searchData = searchResponseData.results ?? []
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }


    func followUnFollow(follower_id: String, completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.followOrUnfollowUser(follower_id:follower_id) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let msgModel):
                       self?.msgModel = msgModel
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }
    
    

    
    func getFollowingUser(target_uid: String, completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.fetchUserFollowingUsers(target_uid: target_uid) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let searchResponseData):
                       self?.follwList = searchResponseData
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }
    
    func getAllLiveStream( completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.getAllLiveStream() { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let searchResponseData):
                       self?.allLiveStream = searchResponseData.results.forYouLiveStraems!
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }

    
    func getAllCountryCodeKey( completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.getCountryKeys() { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let searchResponseData):
                       self?.countryCodeArr = searchResponseData.results
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }

    func getMyFollowerUser(completion: @escaping (Bool, Error?) -> Void) {
           NetworkManager.shared.fetchMYFollowerUsers() { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let searchResponseData):
                       self?.follwList = searchResponseData
                       
                       
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }

//
//    func getCountryCode(completion: @escaping (Bool, Error?) -> Void) {
//           NetworkManager.shared.fetchCountryCode() { [weak self] result in
//               DispatchQueue.main.async {
//                   switch result {
//                   case .success(let countreyCodes):
//                       
//
//                       self?.countryCode = countreyCodes
//
//
//                       completion(true, nil)
//                   case .failure(let error):
//                       print("Error fetching search results: \(error)")
//                       completion(false, error)
//                   }
//               }
//           }
//       }

    
    func getUserProfileData(completion: @escaping (Bool, Error?) -> Void) {
           NetworkManager.shared.fetchUserProfile(uid: Helper.shared.getId() ?? "") { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let profileData):
                       
                       self?.profileList = profileData 
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }
    
    
    
    func getLiveStreamData(completion: @escaping (Bool, Error?) -> Void) {
           NetworkManager.shared.fetchLiveStream(page: "0", perPage: "5") { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let liveData):
                       
                       self?.liveStramArray = liveData.data ?? []
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }

    func getNotifcation(completion: @escaping (Bool, Error?) -> Void) {
        NetworkManager.shared.fetchNotifcation(uid:Helper.shared.getId() ?? "" ) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let liveData):
                       
                       self?.notifcaitonArray = liveData.data ?? []
                       completion(true, nil)
                   case .failure(let error):
                       print("Error fetching search results: \(error)")
                       completion(false, error)
                   }
               }
           }
       }

    func createRomm(){
        let roomRequest = RoomRequest(
            region: "sg001",
            webhook: Webhook(
                endPoint: "https://webhook.site/d3bb5e31-88ef-4234-a9d9-b481b971a14a",
                events: [
                    "participant-joined",
                    "participant-left",
                    "session-started",
                    "session-ended",
                    "recording-started",
                    "recording-stopped",
                    "livestream-started",
                    "livestream-stopped",
                    "hls-started",
                    "hls-stopped"
                ]
            )
        )
        let token = "your_access_token"

        NetworkManager.shared.createRoom(requestData: roomRequest, token: token) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let roomResponse):
                        // Handle success - Update UI if necessary
                        self?.createRoomRespobnse  = roomResponse
                        print("Room created successfully: \(roomResponse)")
                    case .failure(let error):
                        // Handle error - Update UI if necessary
                        print("Error creating room: \(error)")
                    }
                }
            }

    }

    
    
    
}

                                               
                                               
