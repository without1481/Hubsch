//
//  UserDataSecondViewController.swift
//  Hubsch
//
//  Created by Piter Stivenson on 28.02.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class UserDataSecondViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    var coutryList = [Dictionary<String, Any>]()
    var regionList = [Dictionary<String, Any>]()
    
    var countryId:Int = 1
    var regionId:Int = 1

    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var regionPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        regionPicker.delegate = self
        regionPicker.dataSource = self
        regionPicker.isHidden = true
        
        getData(target: "country")
        getData(target: "region")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1

    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPicker {
            return coutryList.count
        }
        else {
            return regionList.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPicker {
            countryId = row + 1
            getData(target: "region")
            User.userCountry = countryId
        }
        if pickerView == regionPicker {
            regionId = row + 1
            User.userRegion = regionId
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPicker {
            return coutryList[row]["name"] as? String
        }
        else {
            return regionList[row]["name"] as? String
        }
    }

    func getData(target: String) {
        
        var scriptUrl = "http://localhost:7878"
        
        switch target {
            case "country":
                scriptUrl += "/country/readAll/\(Hubsch.AppToken)"
            case "region":
                scriptUrl += "/region/readAllRegionsByCountryId/\(Hubsch.AppToken)/\(countryId)"
            default:
                scriptUrl += "/country/readAll/\(Hubsch.AppToken)"
        }
        
        let myUrl = URL(string: scriptUrl);
        
        // Creaste URL Request
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "GET"

        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            // Check for error
            if error != nil {
                self.showAlertView(text: error!.localizedDescription, title: "Error")
                return
            }
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [Dictionary<String, Any>] {
                    
                    switch target {
                        case "country":
                            self.coutryList = convertedJsonIntoDict
                            DispatchQueue.main.async(execute: {
                                self.countryPicker.reloadAllComponents()
                            })
                        case "region":
                            self.regionList = convertedJsonIntoDict
                            DispatchQueue.main.async(execute: {
                                self.regionPicker.isHidden = false
                                self.regionPicker.reloadAllComponents()
                            })
                        default:
                            return
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
