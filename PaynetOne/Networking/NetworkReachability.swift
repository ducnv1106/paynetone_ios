//
//  NetworkReachability.swift
//  PaynetOne
//
//  Created by vinatti on 21/01/2022.
//

import UIKit
import Alamofire

class NetworkReachability {
  let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
  static let shared = NetworkReachability()
  let offlineAlertController: UIAlertController = {
    UIAlertController(title: "No Network", message: "Please connect to network and try again", preferredStyle: .alert)
  }()
  
  func startNetworkMonitoring(){
    reachabilityManager?.startListening {status in
      switch status {
      case .notReachable:
        self.showOfflineAlert()
      case .reachable(.cellular):
        self.dismissOfflineAlert()
      case .reachable(.ethernetOrWiFi):
        self.dismissOfflineAlert()
      case .unknown:
        print("NetworkReachability - Unknown network state")
      }
    }
  }

  func showOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.present(offlineAlertController, animated: true, completion: nil)
  }

  func dismissOfflineAlert() {
    let rootViewController = UIApplication.shared.windows.first?.rootViewController
    rootViewController?.dismiss(animated: true, completion: nil)
  }
}

