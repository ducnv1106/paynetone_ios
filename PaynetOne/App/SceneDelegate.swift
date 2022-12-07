//
//  SceneDelegate.swift
//  PaynetOne
//
//  Created by vinatti on 27/12/2021.
//

import UIKit
import SwiftTheme

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var currentBackgroundDate = NSDate()
    private var isBackground = false

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.rootViewController = RootViewController()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        let userData = StoringService.shared.getData(Constants.userData)
        DispatchQueue.main.async {
            switch UITraitCollection.current.userInterfaceStyle {
            case .light, .unspecified:
                
                if isDarkMode {
                    NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.LIGHT)
                    ThemeManager.setTheme(index: 1)
                    StoringService.shared.wirteBool(value: false, key: "IS_DARK_MODE")
                    isDarkMode = !isDarkMode

                }else{
                    NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
                }
                
             
                
            case .dark:
               
                if !isDarkMode {
                    NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.DARKMOD)
                    ThemeManager.setTheme(index: 1)
                    StoringService.shared.wirteBool(value: true, key: "IS_DARK_MODE")
                    isDarkMode = !isDarkMode
        
                }else{
                    NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
                }
            @unknown default:
                break
//                if isDarkMode {
//                    NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.LIGHT)
//                    ThemeManager.setTheme(index: 1)
//                    StoringService.shared.wirteBool(value: false, key: "IS_DARK_MODE")
//                }else{
//                    NotificationCenter.default.post(name: .userInterfaceStyle, object: UserInterfaceStyle.NOTHING)
//                }
            }
        }
        if userData.isEmpty {
            print("------chưa login")
        } else {
            let diff = currentBackgroundDate.timeIntervalSince(NSDate() as Date)
            if isBackground && -diff > 180 {
                StoringService.shared.removeData(Constants.userData)
                StoringService.shared.removeData(Constants.configData)
                StoringService.shared.removeData("ADDRESS_BY_PAYNETID")
                StoringService.shared.removeData("KEY_IS_EXST_PIN_CODE")
                StoringService.shared.removeData("KEY_PAYNET_HAS_CHILDREN")
//                DBManager.realmDeleteAllClassObjects()
//                rootViewController.switchToRegister()
                window?.rootViewController = RootViewController()
                window?.makeKeyAndVisible()
                isBackground = false
            }
        }
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        currentBackgroundDate = NSDate()
        isBackground = true
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func changeUserInterfaceStyleForeground(){
      
    }

}

extension SceneDelegate {
    static var shared: SceneDelegate {
        return UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    }
    
    //RootViewController
    var rootViewController: RootViewController {
        return window!.rootViewController as! RootViewController
    }
}
