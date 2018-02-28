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
    
    var viewControllers = [UIViewController]()
    var firstViewController:UIViewController?
    var secondViewController:UIViewController?
    var thirdViewController:UIViewController?
    
    var currentPage:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstViewController = storyboard?.instantiateViewController(withIdentifier: "UserDataFirst") as! UserDataFirstViewController
        
        secondViewController = storyboard?.instantiateViewController(withIdentifier: "UserDataSecond") as! UserDataSecondViewController
        thirdViewController = storyboard?.instantiateViewController(withIdentifier: "UserDataThird") as! UserDataThirdViewController
        
        nextStepButton.tag = 0
        viewControllers = [firstViewController!,secondViewController!,thirdViewController!]
    }
    
    @IBAction func nextStep(_ sender: UIButton) {
    
        
    }

}
