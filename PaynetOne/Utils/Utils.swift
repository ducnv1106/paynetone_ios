//
//  Utils.swift
//  PaynetOne
//
//  Created by vinatti on 07/01/2022.
//

import Foundation
import UIKit
import ObjectMapper
import Photos

class Utils {
    static func formatCurrency(amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.currencySymbol = "VNĐ"
        formatter.currencyGroupingSeparator = ","
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.numberStyle = .currency
        formatter.positiveFormat = "#,##0 ¤"
        return formatter.string(from: amount as NSNumber) ?? String(format: "%@%@")
    }
    
    static func generateQRCode(string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 6, y: 6)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    static func currencyFormatter(amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.numberStyle = .currency
        return (formatter.string(from: NSNumber(value: amount)) ?? "0").replacingOccurrences(of: ".", with: ",")
    }
    
    static func numberFormatter(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number))?.replacingOccurrences(of: ".", with: ",") ?? "0"
    }
    
    static func objToString<T: BaseMappable>(_ object: T) -> String {
        return Mapper().toJSONString(object) ?? ""
    }
}
func callNumber(phoneNumber: String) {
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
        let application = UIApplication.shared
        if application.canOpenURL(phoneCallURL) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
    }
}
func mailTo(email: String) {
    if let url = URL(string: "mailto:\(email)") {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
func openLink(link: String){
    if let link = URL(string: link) {
        UIApplication.shared.open(link)
    }
}
func popToViewController(navigationController: UINavigationController, className: AnyClass) {
    for vc in navigationController.viewControllers as [UIViewController] {
        if vc.isKind(of: className) {
            navigationController.popToViewController(vc, animated: true)
            return
        }
    }
}
func getAssetThumbnail(asset: PHAsset) -> UIImage {
    let retinaScale = UIScreen.main.scale
    //    let retinaSquare = CGSize(width: size * retinaScale, height: size * retinaScale)
    let cropSizeLength = min(asset.pixelWidth, asset.pixelHeight)
    let square = CGRect(x: 0, y: 0, width: CGFloat(cropSizeLength), height: CGFloat(cropSizeLength))
    let cropRect = square.applying(CGAffineTransform(scaleX: 1.0/CGFloat(asset.pixelWidth), y: 1.0/CGFloat(asset.pixelHeight)))
    
    //    let manager = PHImageManager.default()
    //    let options = PHImageRequestOptions()
    //    var thumbnail = UIImage()
    
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var thumbnail = UIImage()
    option.isSynchronous = true
    option.isNetworkAccessAllowed = true
    manager.requestImage(for: asset, targetSize: CGSize(width: 138, height: 138), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
        if result != nil {
            thumbnail = result!
        }
       
    })
    //            cell.imageView.image = thumbnail
    
    //    options.isSynchronous = true
    //    options.isNetworkAccessAllowed = true
    //    options.deliveryMode = .highQualityFormat
    //    options.resizeMode = .exact
    //
    ////    options.normalizedCropRect = cropRect
    //
    //    manager.requestImage(for: asset, targetSize: .zero, contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
    //        if result != nil{
    //            thumbnail = result!
    //        }
    //
    //    })
    return thumbnail
}
