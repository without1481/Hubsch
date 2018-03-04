//
//  RegistrationRouterViewController.swift
//  Hubsch
//
//  Created by Piter Stivenson on 28.02.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import UIKit

class RegistrationRouterViewController: UIViewController {

    @IBOutlet weak var changedContent: UIView!
    @IBOutlet weak var progressIndicator: UIView!
    @IBOutlet weak var nextStepButton: UIButton!
    
    var firstRespond:Bool = true
    var isFirstVC = true
    var isThirdVC = false
    let defaults = UserDefaults.standard
    
    var viewControllers = [UIViewController]()
    
    private lazy var firstViewController: UserDataFirstViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "UserDataFirst") as! UserDataFirstViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var secondViewController: UserDataSecondViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "UserDataSecond") as! UserDataSecondViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var thirdViewController: UserDataThirdViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "UserDataThird") as! UserDataThirdViewController
        
        // Add View Controller as Child View Controller
        //self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [firstViewController,secondViewController,thirdViewController]
        nextStepButton.tag = 0
        nextStepButton.layer.cornerRadius = 5
        nextStep(nextStepButton)
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.changedContent.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.changedContent.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    @IBAction func nextStep(_ sender: UIButton) {
        
        if sender.tag == (viewControllers.count - 1) {
            registation()
        }
        else {
            if firstRespond {
                add(asChildViewController: viewControllers[sender.tag])
                firstRespond = !firstRespond
            }
            else {
                
                if checkInputData() {
                    return
                }
                
                remove(asChildViewController: viewControllers[sender.tag])
                sender.tag += 1
                add(asChildViewController: viewControllers[sender.tag])
                
                if sender.tag == (viewControllers.count - 1) {
                    self.nextStepButton.titleLabel?.text = "Registrate me"
                }
            }
        }
    }
    
    func checkInputData() -> Bool {
        if isFirstVC {
            if (User.userName == "") {
                showAlertView(text: "Please fill name", title: "Warning")
                return true
            }
            
            if (User.userSurname == "") {
                showAlertView(text: "Please fill surname", title: "Warning")
                return true
            }
        }
        else if isThirdVC {
            if (User.userEmail == "") {
                showAlertView(text: "Please fill email", title: "Warning")
                return true
            }
        }
        
        return false
    }
    
    func registation() {

        let url = "http://localhost:7878/user/create/\(Hubsch.AppToken)/\(User.userEmail)/\(User.userPassword)/\(User.userName)/\(User.userSurname)/\(User.userBirthday)/\(User.userGender)/\(User.userCountry)/\(User.userRegion)"
        
        // Creaste URL Request
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                self.showAlertView(text: error!.localizedDescription, title: "Error")
                return
            }
            
            User.userID = String(data: data!, encoding: String.Encoding.utf8)!
            DispatchQueue.main.async {
                
                self.defaults.set(User.userEmail, forKey: "UserEmail")
                self.defaults.set(User.userSurname, forKey: "UserSurname")
                self.defaults.set(User.userName, forKey: "UserName")
                
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "router") as? NavigationRouterViewController
                self.present(controller!, animated: true, completion: nil)
            }
        }
        task.resume()
    }

}
