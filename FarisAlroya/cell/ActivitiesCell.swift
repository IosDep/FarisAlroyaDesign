//
//  ActivitiesCell.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit

class ActivitiesCell: UICollectionViewCell {
    
    
    @IBOutlet weak var selectedBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var activityLabel: UILabel!
    
    var activity : Activity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    

}

protocol ActivityDelegate {
    
    func activityPressed(activity : Activity , flag : String , id : String)
}


struct Activity {
    var activity : String
    var selected : Bool
}
