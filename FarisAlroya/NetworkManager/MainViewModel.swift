import Foundation

class MainViewModel {
    var videos: [NewAppendItItems] = []
    var currentPage = 0
    var hasMoreData = true
    var isLoading = false

    func getMainVideos(uid: String, state: String, pageSize: Int , page :Int, completion: @escaping (Bool, Error?) -> Void) {
        guard !isLoading && hasMoreData else {
            completion(false, nil)
            return
        }

        isLoading = true

        NetworkManager.shared.fetchVideos(uid: uid, state: state, pageSize: pageSize,page: page) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let newVideos):
                    if newVideos.isEmpty {
                        
                        completion(false, nil) // No more data
                    } else {
                        self?.videos.append(contentsOf: newVideos)
                        
                        completion( false, nil
                           )
                    }
                case .failure(let error):
                    print("Error fetching videos: \(error.localizedDescription)")
                    completion(false, error)
                }
            }
        }
    }
}
