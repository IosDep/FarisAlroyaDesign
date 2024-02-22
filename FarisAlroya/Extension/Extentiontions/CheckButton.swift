//
//  CheckButton.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 08/01/2024.
//

import Foundation
import UIKit

@IBDesignable
class CheckButton: ButtonWithImage {

    @IBInspectable
    var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
            self.titleLabel?.textColor = #colorLiteral(red: 0.4336046576, green: 0.4835631251, blue: 0.7567360997, alpha: 1)
            self.tintColor = #colorLiteral(red: 0.4336046576, green: 0.4835631251, blue: 0.7567360997, alpha: 1)
            titleLabel?.font = .boldSystemFont(ofSize: 10)
        }
    }

    @IBInspectable
    var isBold: Bool = false {
        didSet {
            if isBold {

            }
        }
    }

    @IBInspectable
    var isChecked: Bool = false {
        didSet {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
             generator.prepare()
             generator.impactOccurred()
            self.setImage(UIImage(named: isChecked ? "check" : "un-Check"), for: .normal)
        }
    }
}
