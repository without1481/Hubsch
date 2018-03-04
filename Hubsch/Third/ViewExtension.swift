//
//  ViewExtension.swift
//  Hubsch
//
//  Created by Piter Stivenson on 02.03.2018.
//  Copyright © 2018 iPiterGroup. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertView(text: String, title: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
