//
//  CountryTableViewCell.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 09/01/2024.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    
    @IBOutlet var countryCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var checkImageView: UIImageView!

    var onAction: (() -> Void)?
    var cellAction: (() -> Void)?



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkImageView.isHidden = true
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(with country: CountryCodeArra) {
        countryLabel.text = country.country_phone_key
    }


}
