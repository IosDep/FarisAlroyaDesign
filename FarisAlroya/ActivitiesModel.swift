//
//  PickerDataModel.swift
//  FarisAlroya
//
//  Created by Blue Ray on 23/11/2023.
//

import Foundation



class ActivitiesModel {
    
    
    var name  , uuid : String?
    var id:Int?
    init(data: [String: Any]) {
        
        
        if let name = data["hashtag"] as? String {
            self.name = name
        }
        
        
        if let id = data["id"] as? Int {
            self.id = id
        }
        
//        if let uuid = data["uuid"] as? String {
//            self.uuid = uuid
//        }
//        
    }
        
    
}
