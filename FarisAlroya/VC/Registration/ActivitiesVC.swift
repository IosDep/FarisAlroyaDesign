//
//  ActivitiesVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import Alamofire
import JGProgressHUD

class ActivitiesVC: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    static var activities : [Int] = []
    var activitiesHolder : [ActivityHolder] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getActivities()
        
       
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ActivitiesCell", bundle: nil), forCellWithReuseIdentifier: "ActivitiesCell")
        
        
        
    }
    

 
    

    
    
    @IBAction func nextPressed(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        
        self.navigationController?.pushViewController(vc, animated: true)
                
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        
    }
    
    
    
    @IBAction func notNowPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return activitiesHolder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesCell", for: indexPath) as? ActivitiesCell
        
        if activitiesHolder[indexPath.row].selected == true {
            
            cell?.selectedBtn.isHidden = false
            cell?.mainView.backgroundColor = UIColor(red: 0.85, green: 0.94, blue: 1.00, alpha: 1.00)
            
        }
        
        else {
            
            cell?.selectedBtn.isHidden = true
            cell?.mainView.backgroundColor = .clear

        }
        
        cell?.activityLabel.text = activitiesHolder[indexPath.row].activitty.name ?? ""
                
        let labelSize = cell?.activityLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: cell?.activityLabel.frame.size.height ?? 50.0))

            // Update cell width constraint based on label size
        cell?.contentView.frame.size.width = (labelSize?.width ?? 100.0)  + 10.0 ?? 150.0
                
            
            return cell!
            
            
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if activitiesHolder[indexPath.row].selected  == false {
            
            activitiesHolder[indexPath.row].selected  = true
            
            ActivitiesVC.activities.append(activitiesHolder[indexPath.row].activitty.id ?? 0)

        }
        
        else {
            activitiesHolder[indexPath.row].selected = false
        }
        
        self.collectionView.reloadData()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

         // collectionView.bounds.height
        let h = 50.0
        let w = collectionView.bounds.width / 20

        return CGSize(width: w, height: h)

    }
    
    
    func getActivities() {

        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let link =  ServerConstants.BASE_URL  + "/frontend/getHashtags"

     
            
        AF.request(link, method: .post).response { (response) in
            if response.error == nil {
                do {
                    
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        if let obj = jsonObj!["msg"] as? [String:Any] {
                            let  status = obj["status"] as? Int
                            let  message = obj["message"] as? String
                            
                             let data = jsonObj!["results"] as? [[String: Any]]

                            print("SDKajd","\(data)")
                            print("SDKajd123","\(obj)")

                            if status == 200 {
                                
                                self.showSuccessHud(msg: message ?? "", hud: hud)

                                
                                if let data = jsonObj!["results"] as? [[String: Any]] {
                                                                   
                                        
                                    for i in data{
                                        let model = ActivitiesModel(data: i)
                                        self.activitiesHolder.append(ActivityHolder(activitty: model, selected: false))
                                    }
                                    
                                    
                                    self.collectionView.reloadData()

                                }
                                
                                
                            } else {
                                if let obj = jsonObj!["msg"] as? [String:Any] {
                                    
                                    //
                                    if let msg = obj["message"] as? String {
                                        
                                        self.showWarningHud(msg: msg ?? "", hud: hud)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
            
                    
                 catch let err as NSError {
                    print("Error: \(err)")
                     hud.dismiss()
//                    self.serverError(hud: hud)
                }
            } else {
                print("Error")
                hud.dismiss()

//                self.serverError(hud: hud)
                
                
            }
        }
        
    }
    

//    func getActivities() {
//        let link = "http://kenzalarabnew.br-ws.com.dedivirt1294.your-server.de/api/frontend/getHashtags"
////        let credential = URLCredential(user: username, password: password, persistence: .forSession)
//
//        AF.request(link, method: .get).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let jsonArray = value as? [[String: Any]] {
//                    for ac in jsonArray {
//                        let model = ActivitiesModel(data: ac)
//                        self.activitiesHolder.append(ActivityHolder(activitty: model, selected: false))
//                    }
//                }
//                
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
//                
//            case .failure(let error):
//                print("Error: \(error)")
//                // Handle the error
//                // self.serverError(hud: hud)
//            }
//        }
//    }

   
}

struct ActivityHolder {
   
    var activitty : ActivitiesModel
    var selected : Bool
    
}

