//
//  FollowListCell.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit

class FollowListCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
