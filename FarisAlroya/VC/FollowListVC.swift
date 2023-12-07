//
//  FollowListVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit

class FollowListVC: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var list : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "FollowListCell", bundle: nil), forCellReuseIdentifier: "FollowListCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FollowListCell", for: indexPath) as? FollowListCell
        
        cell?.frame.size.width = tableView.bounds.width
        
        return cell!
                
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
//        return self.tableView.frame.size.height
    }
    
   
}
