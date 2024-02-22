//
//  FollowListVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit
import Lottie

class ْUserFollowListVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var viewModel = MainViewModel()

    @IBOutlet weak var followersFlag: UIView!
    @IBOutlet weak var followingFlag: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var watings: LottieAnimationView!

    @IBOutlet weak var no_data: UILabel!
    var list : [String] = []
    var flag : Int?
    
    var target_uid  = ""
    var commingFromUserOrProfile = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        1 for user follower ==> 0 for My follower
        print(target_uid,"eqweqw")
        if commingFromUserOrProfile == 1{
            getUserFollowing()
        }else {
            getMYFollowerList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "UserFollowListCellTableViewCell", bundle: nil), forCellReuseIdentifier: "UserFollowListCellTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        self.watings.play()
        
        print("sdfghjkl",commingFromUserOrProfile)

        let backButton = UIBarButtonItem()
         backButton.title = "رجوع" // Set your custom title
         self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        // followers
        
        if flag == 1 {
            followersFlag.backgroundColor = UIColor(red: 0.16, green: 0.19, blue: 0.34, alpha: 1.00)
            
            followingFlag.backgroundColor = .clear
        }
        
        //following
        
        else {
            
            followingFlag.backgroundColor = UIColor(red: 0.16, green: 0.19, blue: 0.34, alpha: 1.00)

            followersFlag.backgroundColor = .clear
            
        }
        

    }
    
//    @IBAction func doAction(_ sender: UIButton) {
//
//        // followers
//
//        if sender.tag == 1 {
//            followersFlag.backgroundColor = UIColor(red: 0.16, green: 0.19, blue: 0.34, alpha: 1.00)
//
//            followingFlag.backgroundColor = .clear
////            self.viewModel.follwList?.results?.followers.removeAll()
//
//        }
//
//        //following
//
//        else {
//
//            followingFlag.backgroundColor = UIColor(red: 0.16, green: 0.19, blue: 0.34, alpha: 1.00)
//
//            followersFlag.backgroundColor = .clear
////            self.viewModel.follwList?.results?.following.removeAll()
//
//
//
//        }
//
//    }
    
    
    private func getUserFollowing() {

        self.viewModel.follwList?.results?.following?.removeAll()
        viewModel.getFollowingUser(target_uid: target_uid) { [weak self] success, error in
                if success {
                    // Update your UI with the results
                    // For example, reload a table view or collection view
                    self?.watings.isHidden = true
                    self?.tableView.isHidden  =  false

                    self?.tableView.reloadData()
                    
                    if self?.flag == 1 {
                        if self?.viewModel.follwList?.results?.followers?.count == 0{
                            self?.no_data.isHidden = false
                        }else {
                            self?.no_data.isHidden = true
                            
                        }
                    }else {
                        if self?.viewModel.follwList?.results?.following?.count == 0{
                            self?.no_data.isHidden = false
                        }else {
                            self?.no_data.isHidden = true

                        }
                    }
                    
                } else if let error = error {
                    // Handle the error, maybe show an alert to the user
                    print("Error occurred during search: \(error.localizedDescription)")
                    self?.watings.isHidden = true
                    self?.tableView.isHidden  =  false
                    self?.showErrorHud(msg:"Error occurred during search:" )
                    self?.no_data.isHidden = false


                }
            }
        }

    
    private func addFollwoUser(follower_id: String) {
        viewModel.followUnFollow(follower_id: follower_id) { [weak self] success, error in
            DispatchQueue.main.async {
                self?.watings.isHidden = true
                self?.watings.stop()
                

                if success {
                    self?.watings.isHidden = true
                    self?.watings.stop()
                    self?.showSuccessHud(msg: self?.viewModel.msgModel?.message ?? "")
                    if self?.commingFromUserOrProfile == 1{
                        self?.getUserFollowing()
                    }else {
                        

                        self?.getMYFollowerList()
                    }

                } else {
                    self?.showErrorHud(msg: "يرجى المحاولة مجددا")
                    self?.watings.isHidden = true
                    self?.watings.stop()
                    
                }
            }
        }
    }
    
    private func getMYFollowerList() {

        self.viewModel.follwList?.results?.following?.removeAll()
        viewModel.getMyFollowerUser() { [weak self] success, error in
                if success {
                    // Update your UI with the results
                    // For example, reload a table view or collection view
                    self?.watings.isHidden = true
                    self?.tableView.isHidden  =  false
                    self?.tableView.reloadData()
                    
                    if self?.flag == 1 {
                        if self?.viewModel.follwList?.results?.followers?.count == 0{
                            self?.no_data.isHidden = false
                        }else {
                            self?.no_data.isHidden = true
                            
                        }
                    }else {
                        if self?.viewModel.follwList?.results?.following?.count == 0{
                            self?.no_data.isHidden = false
                        }else {
                            self?.no_data.isHidden = true

                        }
                    }
                    
                } else if let error = error {
                    // Handle the error, maybe show an alert to the user
                    print("Error occurred during search: \(error.localizedDescription)")
                    self?.watings.isHidden = true
                    self?.tableView.isHidden  =  false
                    self?.showErrorHud(msg:"Error occurred during search:" )
                    self?.no_data.isHidden = false
                    self?.no_data.text = "Error occurred during search:"

                    
                }
            }
        }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == 1{
            return self.viewModel.follwList?.results?.followers?.count ?? 0

        }else {
            return self.viewModel.follwList?.results?.following?.count ?? 0

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserFollowListCellTableViewCell", for: indexPath) as? UserFollowListCellTableViewCell
 
        cell?.frame.size.width = tableView.bounds.width
        
        if flag == 1 {
            let data =  viewModel.follwList?.results?.followers?[indexPath.row]
            cell?.username.text  = "@ \(data?.user_name ?? "")"
            
            if data?.is_following == true {
                cell?.unfollowView.isHidden = false
                cell?.followView.isHidden = true
            }else {
                cell?.unfollowView.isHidden = true
                cell?.followView.isHidden = false
            }
            
            let img  = data?.profile_image ?? ""
            
            if  img != nil || img.isEmpty{
                cell?.userProfile.image = UIImage(named: "navlogo")
            }else {
                cell?.userProfile.sd_setImage(with:(URL(string: img)), completed: { (image, error, cachType, url) in
                    if error == nil {
                        cell?.userProfile.image = image!

                    }
                })
            }
            
            
        }else {
            let data =  viewModel.follwList?.results?.following?[indexPath.row]
            
            cell?.username.text  = "@ \(data?.user_name ?? "")"

            if data?.is_following == true {
                cell?.unfollowView.isHidden = false
                cell?.followView.isHidden = true
            }else {
                cell?.unfollowView.isHidden = true
                cell?.followView.isHidden = false
            }
            let img  = data?.profile_image ?? ""
            
            if  img != nil || img.isEmpty{
                cell?.userProfile.image = UIImage(named: "navlogo")
            }else {
                cell?.userProfile.sd_setImage(with:(URL(string: img)), completed: { (image, error, cachType, url) in
                    if error == nil {
                        cell?.userProfile.image = image!

                    }
                })
            }
            
        }
        
        cell?.followBtn.tag  = indexPath.row
        cell?.unFollowBtn.tag  = indexPath.row

        cell?.followBtn.addTarget(self, action: #selector(followUser(sender: )), for: .touchUpInside)
        
        cell?.unFollowBtn.addTarget(self, action: #selector(followUser(sender: )), for: .touchUpInside)


        return cell!
                
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
    }
    @objc func followUser(sender:UIButton){
        if flag == 1 {
            let data =  viewModel.follwList?.results?.followers?[sender.tag]

            self.addFollwoUser(follower_id: "\(data?.id ?? 0)")
            
        }else{
            let data =  viewModel.follwList?.results?.following?[sender.tag]

            self.addFollwoUser(follower_id: "\(data?.id ?? 0)")

        }
        
        
    }
   
}
