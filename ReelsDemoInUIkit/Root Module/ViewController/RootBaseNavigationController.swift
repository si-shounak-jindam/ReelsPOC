//
//  RootBaseNavigationController.swift
//  Punjab Kings
//
//  Created by Abhijeet Gawde on 29/01/24.
//

import UIKit

class RootBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.tabBarController?.tabBar.isTranslucent = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return presentedViewController?.preferredStatusBarStyle ?? topViewController?.preferredStatusBarStyle ?? .darkContent
    }
}

