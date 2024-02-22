//
//  Extensions.swift
//  FarisAlroya
//
//  Created by Blue Ray on 08/11/2023.
//

import UIKit
import JGProgressHUD
import Loaf
import MOLH

import Alamofire
extension UIViewController {
    
    
    
    func addRemoveFlagActionSaved(entity_id:String,entity_type:String,flag_id:String, completionHandler: @escaping ((Bool) -> Void)) {


        let favouriteUrl = URL(string: ServerConstants.BASE_URL + "/user/saveOrCancelSaveVideo")
            let favouriteParam: [String: Any] = [
                
                
                "video_id": entity_id,

            ]
            
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
            
          ]
        
        print("ASDADD",Helper.shared.getUserToken())
    
            AF.request(favouriteUrl!, method: .post, parameters: favouriteParam,headers: headers).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        
                        if jsonObj != nil {
                            
                            let msg = jsonObj!["msg"] as? [String:Any]
                           let message = jsonObj!["message"] as? String

                            if let status = msg?["status"] as? Int {
                                if status == 200 {
                                    DispatchQueue.main.async {
                                        
                                        completionHandler(true)
                                    }
                                    
                                    
                                    
                                } else {
                                    
                                        DispatchQueue.main.async {
                                            
                                            
                                            completionHandler(false)
                                        }
                                    
                                }
                            }
                        }
                        
                    } catch let err as NSError {
                        print("Error: \(err)")
                        
                    }
                } else {
                    print("Error")
                    
                }
            }
        }
    
    
    func addRemoveFlagActionLike(entity_id:String,entity_type:String,flag_id:String, completionHandler: @escaping ((Bool) -> Void)) {

      
            
        let favouriteUrl = URL(string: ServerConstants.BASE_URL +  "/user/likeOrUnlikeVideo")

            let favouriteParam: [String: Any] = [
                
                
                "video_id":  entity_id,
                

            ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
            

          ]
            
            AF.request(favouriteUrl!, method: .post, parameters: favouriteParam,headers: headers).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        
                        if jsonObj != nil {
                            
                            let msg = jsonObj!["msg"] as? [String:Any]
                           let message = jsonObj!["message"] as? String

                            if let status = msg?["status"] as? Int {
                                if status == 200 {
                                    DispatchQueue.main.async {
                                        
                                        completionHandler(true)
                                    }
                                    
                                    
                                    
                                    
                                } else {
                                    
                                        DispatchQueue.main.async {
                                            
                                            
                                            
                                            completionHandler(false)
                                        }
                                    
                                }
                            }
                        }
                        
                    } catch let err as NSError {
                        print("Error: \(err)")
                        
                    }
                } else {
                    print("Error")
                    
                }
            }
        }
    
    func showErrorHud(msg: String , hud: JGProgressHUD) {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = msg
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.5)
    }
    
    func showErrorHud(msg: String ) {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = msg
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.5)
    }
    func showSuccessHud(msg: String ) {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = msg
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.5)
    }
    
    func removeHyphens(from string: String) -> String {
        return string.replacingOccurrences(of: "-", with: "")
    }
    func showNoDataLabel(message: String = "No Data", inView view: UIView,wnatShow: Bool = true) {
        if wnatShow == true {
            let noDataLabel = UILabel()
            noDataLabel.text = message
            noDataLabel.textColor = UIColor.systemBlue
            noDataLabel.textAlignment = .center
            noDataLabel.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(noDataLabel)

            NSLayoutConstraint.activate([
                noDataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noDataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                noDataLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
                noDataLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
            
        }else {
            view.removeFromSuperview()
        }
    
       }
    
    func makeShadow(mainView:UIView){
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.5
        mainView.layer.shadowOffset = CGSize(width: 2, height: 2)
        mainView.layer.shadowRadius = 5
        mainView.layer.cornerRadius = 25
    }
    func serverError(hud: JGProgressHUD) {
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.textLabel.text = "Server Error".localized()
        hud.dismiss(afterDelay: 1.5)
    }

    func showSuccessHud(msg: String, hud: JGProgressHUD) {
        //        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        //        hud.textLabel.text = msg
        //        hud.dismiss(afterDelay: 1.5)
        hud.dismiss(afterDelay: 3)
        
        Loaf(msg, state:
                .custom(
                    .init(
                    backgroundColor:
                        UIColor(red: 0.13, green: 0.31, blue: 0.15, alpha: 1.00) ,
                    textColor: .white,
                    tintColor: .white,
                    font: UIFont(name: "din-regular", size: 10) ?? .systemFont(ofSize: 10),                    icon: Loaf.Icon.success,
                    textAlignment: .natural,
                    iconAlignment: .left ,
                    width: .fixed(300))
                ),
             location: .top,
             sender: self)
             .show()    }
    
    func showWarningHud(msg: String, hud: JGProgressHUD) {
        //        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        //        hud.textLabel.text = msg
        //        hud.dismiss(afterDelay: 1.5)
        hud.dismiss(afterDelay: 3)
        
        Loaf(msg, state:
                .custom(
                    .init(
                    backgroundColor:
                        UIColor(red: 0.16, green: 0.19, blue: 0.34, alpha: 1.00)  ,
                    textColor: .white,
                    tintColor: .white,
                    font: UIFont(name: "din-regular", size: 14) ?? .systemFont(ofSize: 10),                    icon: Loaf.Icon.warning,
                    textAlignment: .natural,
                    iconAlignment: .left ,
                    width: .fixed(300))
                ),
             location: .top,
             sender: self)
        .show()    }
    

    
    func showWarningHud(msg: String) {
        //        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        //        hud.textLabel.text = msg
        //        hud.dismiss(afterDelay: 1.5)
        
        Loaf(msg, state:
                .custom(
                    .init(
                    backgroundColor:
                        UIColor(red: 0.16, green: 0.19, blue: 0.34, alpha: 1.00) ,
                    textColor: .white,
                    tintColor: .white,
                    font: UIFont(name: "din-regular", size: 14) ?? .systemFont(ofSize: 10),
                    icon: Loaf.Icon.warning,
                    textAlignment: .natural,
                    iconAlignment: .left ,
                    width: .fixed(300))
                ),
             location: .top,
             sender: self)
        .show()    }
    
 
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
