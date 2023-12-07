//
//  PickerDataModel.swift
//  FarisAlroya
//
//  Created by Blue Ray on 23/11/2023.
//

import Foundation



class PickerDataModel {
    
    
    var name , id : String?
    
    init(data: [String: Any]) {
        
        
        if let name = data["name"] as? String {
            self.name = name
        }
        
        
        if let id = data["id"] as? String {
            self.id = id
        }
        
    }
        
    
}
