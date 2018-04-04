//
//  LoginViewController.swift
//  Hubsch
//
//  Created by Piter Stivenson on 28.02.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    @IBOutlet weak var loginBtn:UIButton!
    @IBOutlet weak var logoImageView:UIImageView!
    @IBOutlet weak var regBtn:UIButton!
    @IBOutlet weak var forgotBtn:UIButton!

    var pending:UIAlertController!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if (defaults.string(forKey: "email") != nil) && (defaults.string(forKey: "password") != nil) {
            emailField.text = defaults.string(forKey: "email")!
            passwordField.text = defaults.string(forKey: "password")!
            login(email: defaults.string(forKey: "email")!, password: defaults.string(forKey: "password")!)
        }
        
        //login(email: "asdasd@gmail.com", password: "1q2w3e4r")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func displaySignUpPendingAlert() {
        pending = UIAlertController(title: "Authorization", message: "Please wait....", preferredStyle: .alert)
        self.present(pending, animated: true, completion: nil)
    }
    
    @IBAction func tapInLoginButton(_ sender:UIButton){
        login(email: emailField.text!, password: passwordField.text!)
    }
    
    private func login(email:String,password:String) {
        
        DispatchQueue.main.async {
            self.displaySignUpPendingAlert()
        }

        let url = "http://localhost:7878/user/readUserByEmailAndPassword/\(Hubsch.AppToken)/\(email)/\(password)"
            
        // Creaste URL Request
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                self.pending.dismiss(animated: true, completion: {
                    self.showAlertView(text: error!.localizedDescription, title: "Error")
                })
                return
            }
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject] {
                    
                    if convertedJsonIntoDict["error"] != nil {
                        self.pending.dismiss(animated: true, completion: {
                            self.showAlertView(text: convertedJsonIntoDict["error"] as! String , title: "Error")
                        })
                        return
                    }
                    
                    User.userEmail = convertedJsonIntoDict["email"] as! String
                    User.userName = convertedJsonIntoDict["firstName"] as! String
                    User.userSurname = convertedJsonIntoDict["secondName"] as! String
                    User.userBirthday = convertedJsonIntoDict["birthDate"] as! String
                    User.userGender = convertedJsonIntoDict["sex"] as! Int
                    User.userCountry = convertedJsonIntoDict["countryEntityFk"]!["id"] as! Int
                    User.userRegion = convertedJsonIntoDict["regionEntityFk"]!["id"] as! Int
                    User.token = convertedJsonIntoDict["userTokenEntityFk"]!["token"] as! String
                    
                    DispatchQueue.main.async(execute: {
                        
                        self.defaults.setValue(email, forKey: "email")
                        self.defaults.setValue(password, forKey: "password")
                        
                        let transition = CATransition()
                        transition.duration = 1
                        transition.type = kCATransitionFade
                        transition.subtype = kCATransitionFromRight
                        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                        
                        self.view.window!.layer.add(transition, forKey: kCATransition)
                        let presentedVC = self.storyboard!.instantiateViewController(withIdentifier: "core") as! CoreRouterViewController
                        let vc = UINavigationController(rootViewController: presentedVC)
                        self.pending.dismiss(animated: true, completion: {
                            self.present(vc, animated: false, completion: nil)

                        })
                    })
                }
            } catch let error as NSError {
                self.pending.dismiss(animated: true, completion: {
                    self.showAlertView(text: error.localizedDescription, title: "Error")
                })
            }
        }
        task.resume()
        
    }
}
