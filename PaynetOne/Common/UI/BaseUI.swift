//
//  BaseUI.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 07/04/2022.
//

import Foundation
import UIKit
import SwiftTheme
class BaseUI: UIViewController {
    var changeUserInterfaceStyle = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isDarkMode {
            self.view.backgroundColor = .black
        }else{
            self.view.backgroundColor = .backgroundColor
        }
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.helvetica.setBold().withSize(16)]
        navigationController?.navigationBar.tintColor = .white
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "nav-bar-back"), style: .plain, target: self, action: #selector(leftBarButtonTouchUpInside))
        leftBarButton.customView?.viewConstraints(size: CGSize(width: 22, height: 22))
        leftBarButton.tintColor = .white
        navigationItem.leftBarButtonItem = leftBarButton
          
//        NotificationCenter.default.addObserver(self, selector: #selector(observerUserInterfaceStyle(_:)), name: .userInterfaceStyle, object: nil)
    }
    
    @objc func leftBarButtonTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
    
//    @objc private func observerUserInterfaceStyle(_ notification: Notification) {
//        let type = notification.object as? UserInterfaceStyle
//        switch type {
//        case .DARKMOD:
//            DispatchQueue.main.async {
//                self.view.subviews.map({ $0.removeFromSuperview() })
//                self.viewDidLoad()
//                self.configBackgorundColor()
//                self.view.layoutIfNeeded()
//                self.configNavigation()
//
//                NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
//            }
//
//        case .LIGHT:
//            DispatchQueue.main.async {
//                self.view.subviews.map({ $0.removeFromSuperview() })
//                self.viewDidLoad()
//                self.configBackgorundColor()
//                self.view.layoutIfNeeded()
//                self.configNavigation()
//                NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
//            }
//        case .NOTHING:
//            break
//        case .none:
//            break
//        }
//    }

//    deinit {
//        NotificationCenter.default.removeObserver(self, name: .userInterfaceStyle, object: nil)
//    }
    
    func configBackgorundColor(){
        if isDarkMode {
            self.view.backgroundColor = .black
        }else{
            self.view.backgroundColor = .backgroundColor
        }
    }
//    func configNavigation(){
//        navigationController?.setNavigationBarHidden(false, animated: true)
//    }
}
