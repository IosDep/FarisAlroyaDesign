//
//  FollowListVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit
import Lottie

class FollowListVC: UIViewController , UITableViewDataSource , UITableViewDelegate ,UISearchBarDelegate{

    @IBOutlet weak var watings: LottieAnimationView!
      @IBOutlet weak var tableView: UITableView!
      @IBOutlet weak var searchTxt: UISearchBar!

    @IBOutlet weak var no_data: UILabel!
    var viewModel = MainViewModel()
      var noDataLabel: UILabel!

      override func viewDidLoad() {
          super.viewDidLoad()
          setupTableView()
          setupSearchBar()
          setupLoadingAnimation()
          setupNoDataLabel()
          self.performSearch(txt: "")
          VideoPlayerController.sharedVideoPlayer.pauseCurrentVideo()

      }

      private func setupTableView() {
          tableView.register(UINib(nibName: "FollowListCell", bundle: nil), forCellReuseIdentifier: "FollowListCell")
          tableView.delegate = self
          tableView.dataSource = self
          tableView.keyboardDismissMode = .interactive
      }

      private func setupSearchBar() {
          searchTxt.delegate = self
      }

      private func setupLoadingAnimation() {
          watings.play()
          watings.loopMode = .loop
          watings.isHidden = true // Initially hidden
      }

      private func setupNoDataLabel() {
          noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
          noDataLabel.text = "No Data"
          noDataLabel.textAlignment = .center
          noDataLabel.isHidden = true // Initially hidden
          view.addSubview(noDataLabel)
      }

      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          guard let searchText = searchBar.text, !searchText.isEmpty else {
              return
          }
          
          noDataLabel.isHidden = true
          watings.isHidden = false
          tableView.isHidden = true

          performSearch(txt: searchText)
      }

      private func performSearch(txt: String) {
          viewModel.searchUsers(searchKey: txt) { [weak self] success, error in
              DispatchQueue.main.async {
                  self?.watings.isHidden = true
                  self?.tableView.isHidden = false
                  self?.searchTxt.isHidden = false

                  if success {
                      self?.tableView.reloadData()
                      if self?.viewModel.searchData == nil ||
                            self?.viewModel.searchData.count == 0 {
                          
                          self?.noDataLabel.isHidden =  false
                          self?.no_data.isHidden  =  false
                        
                      }else {
                          self?.noDataLabel.isHidden =  true
                          self?.no_data.isHidden  =  true

                      }
                  } else {
                      self?.showErrorHud(msg: "Error occurred during search.")
                      self?.noDataLabel.isHidden = false
                      
                      
                  }
              }
          }
      }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.searchData.count

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data  =  viewModel.searchData[indexPath.row]

        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MianVC") as! MianVC

//        vc.modalPresentationStyle =  .fullScreen

        vc.userId = "\(data.id ?? 0)"
        vc.userName = data.user_name ?? ""
        vc.userImageLink = data.profile_image ?? ""
        vc.numOfLike = data.userVideosLikes ?? ""
        vc.numOfFollow = data.userFollowers ?? ""
        vc.numOfFollowing = data.userFollowings ?? ""
        vc.isFollowign =  "\(data.isFollowing ?? 0)"
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data  =  viewModel.searchData[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FollowListCell", for: indexPath) as? FollowListCell
        
        
        print(viewModel.searchData.count,"wekdfa")
        
        cell?.username.text  = data.user_name ?? ""
        
   
            cell?.userImage.sd_setImage(with:(URL(string: data.profile_image ?? "")), completed: { (image, error, cachType, url) in
                if error == nil {
                    cell?.userImage.image = image!

                }else {
                    cell?.userImage.image = UIImage(named: "navlogo")

                }
            })
        
        
        
        
        return cell!
                
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
//        return self.tableView.frame.size.height
    }
    
   
}
