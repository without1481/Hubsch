//
//  UserDataFirstViewController.swift
//  Hubsch
//
//  Created by Piter Stivenson on 28.02.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class UserDataFirstViewController: UIViewController {

    @IBOutlet weak var name:UITextField!
    @IBOutlet weak var surname:UITextField!
    @IBOutlet weak var birthday:UIDatePicker!
    @IBOutlet weak var gender:UISegmentedControl!
    
    let formatter = DateFormatter()
    let router = RegistrationRouterViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        formatter.dateFormat = "yyyy-MM-dd"
        
        name.addTarget(self, action: #selector(checkName), for: .editingChanged)
        surname.addTarget(self, action: #selector(checkSurname), for: .editingChanged)
        birthday.addTarget(self, action: #selector(checkBirthday), for: .valueChanged)
        gender.addTarget(self, action: #selector(checkGender), for: .valueChanged)
        birthday.maximumDate = Date()
        
        User.userBirthday = formatter.string(from: birthday.date)
        User.userGender = gender.selectedSegmentIndex
    }
    
    @objc func checkName () {
        User.userName = name.text!
        //changeStyleStatus(textField: name)
    }
    
    func changeStyleStatus(textField:UITextField) {
        if textField.text! == "" {
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1
        }
        else {
            textField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    @objc func checkSurname() {
        User.userSurname = surname.text!
        //changeStyleStatus(textField: surname)
    }
    
    @objc func checkBirthday () {
        User.userBirthday = formatter.string(from: birthday.date)
    }
    
    @objc func checkGender () {
        User.userGender = gender.selectedSegmentIndex
    }
}
