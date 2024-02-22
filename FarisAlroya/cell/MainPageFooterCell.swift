//
//  MainPageFooterCell.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 17/01/2024.
//

import UIKit
import Lottie
class MainPageFooterCell: UICollectionReusableView {
    @IBOutlet weak var watings: LottieAnimationView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        watings.loopMode = .loop
        watings.play()
    }
    
}
