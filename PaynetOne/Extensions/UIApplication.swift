//
//  UIApplication.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 17/08/2022.
//

import UIKit

extension UIApplication {
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    static func takeAndSaveScreenshot(view:UIView,completion: @escaping (Error?) -> Void) {
//        let keyWindow = UIApplication.shared.connectedScenes
//                .filter({$0.activationState == .foregroundActive})
//                .compactMap({$0 as? UIWindowScene})
//                .first?.windows
//                .filter({$0.isKeyWindow}).first
//        guard let window = keyWindow else { return }
////        let bounds = UIScreen.main.bounds
//
//        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false,  UIScreen.main.scale)
////        window.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
//        window.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
//        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return }
//        UIGraphicsEndImageContext()
        let image = view.asImage()
        let delegate = Delegate(completion: completion)
        UIImageWriteToSavedPhotosAlbum(image, delegate, #selector(Delegate.savedImage(_:error:context:)), nil)
    }
}
final class Delegate: NSObject {
    let completion: (Error?) -> Void

    init(completion: @escaping (Error?) -> Void) {
        self.completion = completion
    }

    @objc func savedImage(
        _ im: UIImage,
        error: Error?,
        context: UnsafeMutableRawPointer?
    ) {
        DispatchQueue.main.async {
            self.completion(error)
        }
    }
}
