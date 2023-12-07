//
//  PickerVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 12/11/2023.
//

import UIKit

class PickerVC: UIViewController , UITableViewDataSource , UITableViewDelegate  {
    
  

    @IBOutlet weak var tableView: UITableView!
    
    var data = [PickerDataModel]()
    var flag : Int?
    var pickerDelegate : PickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PickerCell", bundle: nil), forCellReuseIdentifier: "PickerCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        

    }
    // flag =1 -> ationality
    // flag =2 -> gender
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as? PickerCell
                
       
        cell?.pickerLabel.text = data[indexPath.row].name ?? ""
        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // nationality picker
        
        if flag == 1 {
            
            self.pickerDelegate?.getCountry(country: data[indexPath.row].name ?? "", flag: 1, id: data[indexPath.row].id ?? "")
        }
        
        // gender picker
        
        else if flag == 2 {
            
            self.pickerDelegate?.getGender(gender: data[indexPath.row].name ?? "", flag: 2, id: data[indexPath.row].id ?? "")
            
        }
        
        else if flag == 3 {
            
            self.pickerDelegate?.getNationality(nat: data[indexPath.row].name ?? "", flag: 3, id: data[indexPath.row].id ?? "")
            
        }
        
        
        self.dismiss(animated: true)
        
        
    }
    
    
}


protocol PickerDelegate {
    
    func getGender(gender : String , flag : Int , id : String)
    func getNationality(nat : String , flag : Int , id : String)
    func getCountry(country : String , flag : Int , id : String)

}


struct PickerData {
    
    var name : String
    var id : String
    
    
}
