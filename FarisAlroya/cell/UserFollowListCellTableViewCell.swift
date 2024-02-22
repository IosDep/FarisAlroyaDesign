//
//  UserFollowListCellTableViewCell.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit

class UserFollowListCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var unfollowView: UIView!
    
    @IBOutlet weak var followView: UIView!
    @IBOutlet weak var userProfile: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var unFollowBtn: DesignableButton!
    @IBOutlet weak var followBtn: DesignableButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
