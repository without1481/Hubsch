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
    @IBOutlet weak var backBarItem: UIBarButtonItem!
    
    var firstRespond:Bool = true
    let defaults = UserDefaults.standard
    
    var viewControllers = [UIViewController]()
    
    private lazy var firstViewController: UserDataFirstViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "UserDataFirst") as! UserDataFirstViewController
        return viewController
    }()
    
    private lazy var secondViewController: UserDataSecondViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "UserDataSecond") as! UserDataSecondViewController
        return viewController
    }()
    
    private lazy var thirdViewController: UserDataThirdViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "UserDataThird") as! UserDataThirdViewController
        return viewController
    }()
    
    private lazy var loginViewController: LoginViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
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
            
            if (User.userEmail == "") {
                showAlertView(text: "Please fill email", title: "Warning")
                return
            }
            
            if (User.userPassword == "") {
                showAlertView(text: "Please fill password", title: "Warning")
                return
            }
            
            registation()
        }
        else {
            if firstRespond {
                
                add(asChildViewController: viewControllers[sender.tag])
                firstRespond = !firstRespond
            }
            else {
                
                if (User.userName == "") {
                    showAlertView(text: "Please fill name", title: "Warning")
                    return
                }
                
                if (User.userSurname == "") {
                    showAlertView(text: "Please fill surname", title: "Warning")
                    return
                }
                
                remove(asChildViewController: viewControllers[sender.tag])
                sender.tag += 1
                self.backBarItem.tag += 1
                add(asChildViewController: viewControllers[sender.tag])
                
                if sender.tag == (viewControllers.count - 1) {
                    self.nextStepButton.titleLabel?.text = "Registrate me"
                }
            }
        }
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
                
                self.defaults.set(User.userEmail, forKey: "email")
                self.defaults.set(User.userPassword, forKey: "password")
                
                let presentedVC = self.storyboard!.instantiateViewController(withIdentifier: "login") as! LoginViewController
                self.present(presentedVC, animated: false, completion: nil)
            }
        }
        task.resume()
    }
    
    @IBAction func backItem(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 1:
            remove(asChildViewController: viewControllers[sender.tag])
            sender.tag -= 1
            add(asChildViewController: viewControllers[sender.tag])
        case 2:
            remove(asChildViewController: viewControllers[sender.tag])
            sender.tag -= 1
            add(asChildViewController: viewControllers[sender.tag])
        default:
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
}
