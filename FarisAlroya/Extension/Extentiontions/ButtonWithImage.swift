//
//  ButtonWithImage.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 08/01/2024.
//

import Foundation
import UIKit

class ButtonWithImage: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    var customTitleFont: UIFont? {
        didSet {
            titleLabel?.font = customTitleFont
        }
    }

    private func setup() {
        addSpacing()
    }

    private func addSpacing() {
        var configuration = UIButton.Configuration.plain()
        configuration.titlePadding = 10
        configuration.imagePadding = 15
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)

        // Apply the custom font here
        customTitleFont = .boldSystemFont(ofSize: 20)

        self.configuration = configuration
    }

    @IBInspectable
    var customLeadingInsets: CGFloat = 0 {
        didSet {
            self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: customLeadingInsets, bottom: 10, trailing: 0)
        }
    }
}
