//
//  CategoryCollectionViewCell.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 08/01/2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupConstraints()
        setupCellUI()
    }

    private func setupCellUI(){
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        containerView.layer.borderWidth = 0.3
        containerView.layer.borderColor = #colorLiteral(red: 0.00800000038, green: 0.0120000001, blue: 0.02400000021, alpha: 1)
    }


    func setupCell(_ hashtags: Hashtags){
        titleLabel.text = hashtags.hashtag
    }
    override var isSelected: Bool {
          didSet {
              vibrate()
              containerView.backgroundColor = isSelected ? #colorLiteral(red: 0.7541958094, green: 0.5359829068, blue: 0.2522996068, alpha: 1) : .clear
              titleLabel.textColor = isSelected ? .white : .black
          }
      }
    
    // Set up constraints for the cell's UI components
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }

    func vibrate() {
       let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
}
