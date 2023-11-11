//
//  Extensions.swift
//  FarisAlroya
//
//  Created by Blue Ray on 08/11/2023.
//

import UIKit

class Extensions: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
}


extension UIView {
    func addBorders(borderWidth: CGFloat = 0.5, borderColor: CGColor ){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
    func addShadowToView(shadowRadius: CGFloat = 2) {
        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.3
    }
 
    func roundCorner(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
func animateViewHeight (controller:UIViewController
                        ,height:CGFloat
                        ,heightConstraint:NSLayoutConstraint) {
        UIView.animate(withDuration: 0.5, animations: {
             heightConstraint.constant=height
            controller.view.layoutIfNeeded()
        })
    }

    
    @IBInspectable var bottomRounded: Bool {
        get {
            return layer.maskedCorners == [.layerMaxXMaxYCorner]
        }
        set {
            if newValue {
                layer.cornerRadius = 25
                layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            } else {
                layer.cornerRadius = 0
                layer.maskedCorners = []
            }
        }
    }

    

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}



@IBDesignable
extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue?.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
    }

    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        set {
            layer.shadowOffset = newValue
        }
        get {
            return layer.shadowOffset
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    class InspectableLabel: UILabel {

        @IBInspectable var customFontName: String = "" {
            didSet {
                if let customFont = UIFont(name: customFontName, size: font.pointSize) {
                    font = customFont
                }
            }
        }
        
        // Other label customization code, if needed
        
    }
}
