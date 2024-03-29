

import Foundation
import UIKit
import MOLH


@IBDesignable
//center
class DesignableLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    @IBInspectable
    var Languagable: String {
        get {
            return self.text!
        }
        set(value) {
            self.text = NSLocalizedString(value, comment: "")
        }
    }
}

@IBDesignable
class DesignableLabel2: UILabel {
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    var Languagable: String {
        get {
            return self.text!
        }
        set(value) {
            self.textAlignment = .right
            self.text = NSLocalizedString(value, comment: "")
            
            
        }
    }
}

@IBDesignable
class DesignableLabelWitSpace: UILabel {
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    var Languagable: String {
        get {
            return self.text!
        }
        set(value) {
            self.textAlignment = .right
            self.text = NSLocalizedString(value, comment: "")
            
            // Set the font to "Poppins-Medium"
            if let customFont = UIFont(name: "din-regular.", size: self.font?.pointSize ?? 17.0) {
                self.font = customFont
            }
        }
    }
}


@IBDesignable
class DesignableTextFeild: UITextField {
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    var placeholder_Languagable: String {
        get {
            return self.placeholder!
        }
        set(value) {
            self.attributedPlaceholder =  NSAttributedString(string: NSLocalizedString(value.localized(), comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.cornerRadius = 5
            self.layer.borderWidth = 1
            self.textAlignment = .right
            if MOLHLanguage.isRTLLanguage() == true {
                self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
                self.rightViewMode = .always
            } else {
                self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
                self.leftViewMode = .always
            }
            
        }
    }
    
    
}

@IBDesignable
class DesignableTextFeild2: UITextField {
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    var placeholder_Languagable: String {
        get {
            return self.placeholder!
        }
        set(value) {
            self.attributedPlaceholder =  NSAttributedString(string: NSLocalizedString(value.localized(), comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            
            self.textAlignment = .right
            if MOLHLanguage.isRTLLanguage() == true {
                self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
                self.rightViewMode = .always
            } else {
                self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
                self.leftViewMode = .always
            }
            
        }
    }
    
}

@IBDesignable
class DesignableTextFeild3: UITextField {
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    var placeholder_Languagable: String {
        get {
            return self.placeholder!
        }
        set(value) {
            self.attributedPlaceholder =  NSAttributedString(string: NSLocalizedString(value.localized(), comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
            self.textAlignment = .right
            self.textAlignment = .right
            if MOLHLanguage.isRTLLanguage() == true {
                self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
                self.rightViewMode = .always
            } else {
                self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
                self.leftViewMode = .always
            }
            
        }
    }
}

@IBDesignable
class DesignableTextFeild4: UITextField {
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    var placeholder_Languagable: String {
        get {
            return self.placeholder!
        }
        set(value) {
            self.attributedPlaceholder =  NSAttributedString(string: NSLocalizedString(value.localized(), comment: ""), attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            
            self.textAlignment = .right
            if MOLHLanguage.isRTLLanguage() == true {
                self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
                self.rightViewMode = .always
            } else {
                self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
                self.leftViewMode = .always
            }
            
        }
    }
    
}

@IBDesignable
class DesignableButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable
    var Languagable: String {
        get {
            return self.currentTitle!
        }
        set(value) {
        
            self.setTitle(NSLocalizedString(value, comment: ""), for: state)
            self.titleLabel?.font = UIFont(name: "din-regular", size: self.titleLabel?.font.pointSize ?? 17.0)
            
        }
    }
    
    
}




@IBDesignable
class DesignableLabelFont: UILabel {
    
    // Custom switch to toggle the font change.
    @IBInspectable var useSpecialFont: Bool = false {
        didSet {
            updateFont()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateFont()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateFont()
    }
    
}

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: self, comment: "")
    }
}
