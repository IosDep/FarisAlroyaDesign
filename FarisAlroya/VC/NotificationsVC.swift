//
//  FollowListVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit

class NotificationsVC: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var list : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(UINib(nibName: "FollowListCell", bundle: nil), forCellReuseIdentifier: "FollowListCell")
        
        
        tableView.register(UINib(nibName: "NotificationsHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "NotificationsHeader")
        
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    
    @IBAction func notificationSettingPressed(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationPopupVC") as? NotificationPopupVC
        
            present(vc!, animated: false, completion: nil)
            
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FollowListCell", for: indexPath) as? FollowListCell
        
        return cell!
                
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NotificationsHeader") as? NotificationsHeader
        
        return headerView
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 35
    }
   
}
