//
//  UploadeVideos.swift
//  
//
//  Created by MOHAMMED JABER on 17/01/2024.
//

import UIKit

    
    class UploadeVideos: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {
        
    @IBOutlet weak var collection: UICollectionView!

        
        
        static var activities : [String] = []
        var activitiesHolder : [ActivityHolder] = []
        
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.



        collection. = self
        collection.delegate = self
        
        
        
        
        
        collection


    }
    

    @IBAction func doActionUplaode(_ sender: UIButton) {
        

        
    }
    
    @IBAction func reachVideos(_ sender: UIButton) {
        

        
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
                
                ActivitiesVC.activities.append(activitiesHolder[indexPath.row].activitty.id ?? "")

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
        
        let username = "mohammadAhmad"
        let password = "123"

        let credential = URLCredential(user: username, password: password, persistence: .forSession)

        AF.request(link, method: .get).authenticate(with: credential).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonArray = value as? [[String: Any]] {
                    for ac in jsonArray {
                        let model = ActivitiesModel(data: ac)
                        self.activitiesHolder.append(ActivityHolder(activitty: model, selected: false))
                    }
                }
                
                DispatchQueue.main.async {
                    self.collection.reloadData()
                }
                
            case .failure(let error):
                print("Error: \(error)")
                // Handle the error
                // self.serverError(hud: hud)
            }
        }
    }


}
