//
//  Display.swift
//  PaynetOne
//
//  Created by Duoc Nguyen  on 09/11/2022.
//

import UIKit

public enum DisplayTypeIp {
    case unknown
    case iphone4
    case iphone5
    case iphone6
    case iphone6plus
    static let iphone7 = iphone6
    static let iphone7plus = iphone6plus
    case iphoneX
}

var isSplitOrSlideOver: Bool = {
    guard let w = UIApplication.shared.delegate?.window, let window = w else { return false }
    return !window.frame.equalTo(window.screen.bounds)
}()

public final class Display {
    class var bounds: CGRect {
        if isSplitOrSlideOver, let window = UIApplication.shared.delegate?.window {
            return window?.frame ?? UIScreen.main.bounds
        }
        return UIScreen.main.bounds
    }
    class var size: CGSize { return bounds.size }
    class var width: CGFloat { return landscape ? size.height : size.width }
    class var height: CGFloat { return landscape ? size.width : size.height }
    class var maxLength: CGFloat { return max(width, height) }
    class var minLength: CGFloat { return min(width, height) }
    class var zoomed: Bool { return UIScreen.main.nativeScale >= UIScreen.main.scale }
    class var retina: Bool { return UIScreen.main.scale >= 2.0 }
    class var phone: Bool { return isSplitOrSlideOver || UIDevice.current.userInterfaceIdiom == .phone }
    class var pad: Bool { return !isSplitOrSlideOver && UIDevice.current.userInterfaceIdiom == .pad }
    class var landscape: Bool { return UIDevice.current.orientation.isLandscape }
    class var portrait: Bool { return UIDevice.current.orientation.isPortrait }
    
    class var widthOrignal: CGFloat { return size.width }
    class var heightOrignal: CGFloat { return size.height }
    
    class func safeLayoutWidth() -> CGFloat {
        var width = Display.width
        if #available(iOS 11.0, *), let window = UIApplication.getKeyWindow() {
            width -= (window.safeAreaInsets.left + window.safeAreaInsets.right)
        }
        return width
    }
    
    class var typeIsLike: DisplayTypeIp {
        if phone && maxLength < 568 {
            return .iphone4
        }
        else if phone && maxLength == 568 {
            return .iphone5
        }
        else if phone && maxLength == 667 {
            return .iphone6
        }
        else if phone && maxLength == 736 {
            return .iphone6plus
        }
        else if phone && maxLength >= 812 {
            return .iphoneX
        }
        return .unknown
    }
    
    class var iPhoneX: Bool {
        return typeIsLike == .iphoneX
    }
    
    class var iPhone4_5: Bool {
        return typeIsLike == .iphone4 || typeIsLike == .iphone5
    }

}

extension UIApplication {
    class func getKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first ?? UIApplication.shared.keyWindow
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
