//
//  LiveVideoTabelView.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 04/02/2024.
//

import UIKit

class LiveVideoTabelView: UITableViewCell {

    @IBOutlet weak var otherTxt: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imagUser: UIImageView!
    @IBOutlet weak var liveView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
