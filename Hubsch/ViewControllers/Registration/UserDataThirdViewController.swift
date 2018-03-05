//
//  UserDataThirdViewController.swift
//  Hubsch
//
//  Created by Piter Stivenson on 28.02.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class UserDataThirdViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userRepeatPassword: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        
        userEmail.addTarget(self, action: #selector(checkEmail), for: .allEditingEvents)
        userPassword.addTarget(self, action: #selector(checkPassword), for: .allEditingEvents)
        userRepeatPassword.addTarget(self, action: #selector(checkRepeatPassword), for: .allEditingEvents)
    }
    
    @objc func checkEmail () {
        if isValidEmail(email: userEmail.text!) {
            User.userEmail = userEmail.text!
        }
    }
    
    @objc func checkPassword () {
        
    }
    
    @objc func checkRepeatPassword () {
        if userPassword.text! == userRepeatPassword.text! {
            User.userPassword = userPassword.text!
        }
        else {
            User.userPassword = ""
        }
    }
    
    func isValidEmail(email:String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
