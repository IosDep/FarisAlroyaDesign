//
//  ActivitiesVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit

class ActivitiesVC: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var activities : [Activity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 30
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ActivitiesCell", bundle: nil), forCellWithReuseIdentifier: "ActivitiesCell")
        
        self.activities = [Activity(activity: "razan azmi", selected: false) , Activity(activity: "razannnsssA", selected: false) , Activity(activity: "r", selected: false) , Activity(activity: "raz", selected: false)]
        
        
    }
    
    @IBAction func signinPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Loginvc") as! Loginvc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    
    
    

    @IBAction func nextPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesCell", for: indexPath) as? ActivitiesCell
        
        
        if activities[indexPath.row].selected == true {
            
            cell?.selectedBtn.isHidden = false
            cell?.mainView.backgroundColor = UIColor(red: 0.93, green: 0.99, blue: 0.96, alpha: 1.00)

            
        }
        
        else {
            
            cell?.selectedBtn.isHidden = true
            cell?.mainView.backgroundColor = .clear

            
        }
        
        cell?.activityLabel.text = activities[indexPath.row].activity ?? ""
                
        let labelSize = cell?.activityLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: cell?.activityLabel.frame.size.height ?? 50.0))

            // Update cell width constraint based on label size
        cell?.contentView.frame.size.width = (labelSize?.width ?? 100.0)  + 10.0 ?? 150.0
                
            
            return cell!
            
            
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if activities[indexPath.row].selected == false {
            
            activities[indexPath.row].selected = true

        }
        
        else {
            activities[indexPath.row].selected = false
        }
        
        
        collectionView.reloadData()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


         // collectionView.bounds.height

        let h = 50.0
        let w = collectionView.bounds.width / 20

        return CGSize(width: w, height: h)


    }
    
    
   
}
