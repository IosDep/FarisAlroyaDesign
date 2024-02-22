//
//  Localization+EX.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 15/01/2024.
//

import UIKit

extension UILabel {
    @IBInspectable public var localization: String? {
        get {
            return nil
        }
        set {
            if let key = newValue {
                text = NSLocalizedString(key, comment: "")
            }
        }
    }
}

extension UIButton {
    @IBInspectable public var localization: String? {
        get {
            return nil
        }
        set {
            if let key = newValue {
                setTitle(NSLocalizedString(key, comment: ""), for: .normal)
            }
        }
    }
}

extension UITextField {
    @IBInspectable public var localizationPlaceholder: String? {
        get {
            return nil
        }
        set {
            if let key = newValue {
                placeholder = NSLocalizedString(key, comment: "")
            }
        }
    }
}

extension UITextView {
    @IBInspectable public var localization: String? {
        get {
            return nil
        }
        set {
            if let key = newValue {
                text = NSLocalizedString(key, comment: "")
            }
        }
    }

    @IBInspectable public var localizationPlaceholder: String? {
        get {
            return nil
        }
        set {
            if let key = newValue {
                self.text = NSLocalizedString(key, comment: "")
            }
        }
    }
}
