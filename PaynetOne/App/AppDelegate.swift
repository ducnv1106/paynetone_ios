//
//  AppDelegate.swift
//  PaynetOne
//
//  Created by vinatti on 27/12/2021.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseMessaging
import SwiftTheme


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    private var currentBackgroundDate = NSDate()
    
    func applicationWillTerminate(_ application: UIApplication) {
        clearDataWhenLogout()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        switch UITraitCollection.current.userInterfaceStyle {
        case .light, .unspecified:
            ThemeManager.setTheme(index: 1)
            StoringService.shared.wirteBool(value: false, key: "IS_DARK_MODE")
            
        case .dark:
            ThemeManager.setTheme(index: 0)
            StoringService.shared.wirteBool(value: true, key: "IS_DARK_MODE")
            // dark mode detected
        @unknown default:
            ThemeManager.setTheme(index: 1)
            StoringService.shared.wirteBool(value: true, key: "IS_DARK_MODE")
        }
        let newNavBarAppearance = CustomNavBar.customNavBarAppearance()
        let appearance = UINavigationBar.appearance()
        appearance.scrollEdgeAppearance = newNavBarAppearance
        appearance.compactAppearance = newNavBarAppearance
        appearance.standardAppearance = newNavBarAppearance
        if #available(iOS 15.0, *) {
            appearance.compactScrollEdgeAppearance = newNavBarAppearance
        }
        
        NetworkReachability.shared.startNetworkMonitoring()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in}
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
//        let message = userInfo["message"] as? String
//        SwiftEventBus.post("PAYMENT_SUCCESS", sender: message)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("---",userInfo)
        
//        let message = userInfo["message"] as? String
//        SwiftEventBus.post("PAYMENT_SUCCESS", sender: message)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("========error send noti", error)
    }
    
    func clearDataWhenLogout(){
        StoringService.shared.removeData(Constants.userData)
        StoringService.shared.removeData(Constants.configData)
        StoringService.shared.removeData("ADDRESS_BY_PAYNETID")
        StoringService.shared.removeData("KEY_IS_EXST_PIN_CODE")
        StoringService.shared.removeData("KEY_PAYNET_HAS_CHILDREN")
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        process(notification)
        print("====================")
        if #available(iOS 14.0, *) {
            completionHandler([[.banner, .sound]])
        } else {
            completionHandler([.badge, .sound])
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        process(response.notification)
        print("====================+")
        completionHandler()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    private func process(_ notification: UNNotification) {
        let userInfo = notification.request.content.userInfo
        UIApplication.shared.applicationIconBadgeNumber = 0
        Messaging.messaging().appDidReceiveMessage(userInfo)
        print("=======foreground", notification.request.content.userInfo["message"] as? String)
        print("----", notification.request.content.userInfo)
        
        let message = notification.request.content.userInfo["message"] as? String


        
        
        
        
        //        [AnyHashable("title"): [PAYNETONE -  GIAO DỊCH THÀNH CÔNG], AnyHashable("google.c.a.e"): 1, AnyHashable("aps"): {
        //            alert =     {
        //                body = "Kh\U00e1ch h\U00e0ng v\U1eeba thanh to\U00e1n th\U00e0nh c\U00f4ng s\U1ed1 ti\U1ec1n 50,000 vn\U0111, m\U00e3 \U0111\U01a1n h\U00e0ng l\U00e0 2208220004939 t\U1ea1i c\U1eeda h\U00e0ng c\U1ee7a b\U1ea1n";
        //                title = "[PAYNETONE -  GIAO D\U1ecaCH TH\U00c0NH C\U00d4NG]";
        //            };
        //        }, AnyHashable("gcm.message_id"): 1660900065665937, AnyHashable("message"): Mã đơn hàng 2208220004939 đã thanh toán thành công., AnyHashable("gcm.notification.message"): Mã đơn hàng 2208220004939 đã thanh toán thành công., AnyHashable("google.c.sender.id"): 753424440138, AnyHashable("google.c.fid"): ck1oTrORWUu3qW6Fk2r2rx, AnyHashable("body"): Khách hàng vừa thanh toán thành công số tiền 50,000 vnđ, mã đơn hàng là 2208220004939 tại cửa hàng của bạn]
        for vc in SceneDelegate.shared.rootViewController.navController.viewControllers as [UIViewController] {
            if vc.isKind(of: InfoQRCreatedVC.self) {
//                SwiftEventBus.post("PAYMENT_SUCCESS")
                SwiftEventBus.post("PAYMENT_SUCCESS", sender: message)

            }
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
      }
}
