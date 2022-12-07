//
//  SplashViewController.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 07/07/2022.
//

import UIKit

var isDarkMode = StoringService.shared.isDarkMode()
class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let userData = StoringService.shared.getData(Constants.userData)
        if userData != "" {
            SceneDelegate.shared.rootViewController.switchToMain()
        } else {
            SceneDelegate.shared.rootViewController.switchToRegister()
        }
    }
}
