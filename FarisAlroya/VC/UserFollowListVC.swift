//
//  FollowListVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit

class ْUserFollowListVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
    

    @IBOutlet weak var followersFlag: UIView!
    @IBOutlet weak var followingFlag: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var list : [String] = []
    var flag : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "UserFollowListCellTableViewCell", bundle: nil), forCellReuseIdentifier: "UserFollowListCellTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserFollowListCellTableViewCell", for: indexPath) as? UserFollowListCellTableViewCell
        
        if indexPath.row == 0 {
            
            cell?.unfollowView.isHidden = true
            cell?.followView.isHidden = false

        }
        
        else {
            
            cell?.unfollowView.isHidden = false
            cell?.followView.isHidden = true
        }
        
//        cell?.frame.size.width = tableView.bounds.width
        
        return cell!
                
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
    }
    
   
}
