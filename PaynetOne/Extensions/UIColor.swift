//
//  UIColor.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 06/08/2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    static let backgroundColor: UIColor = {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //255, 255, 255
    }()
    static let textGray: UIColor = {
        return #colorLiteral(red: 0.5019607843, green: 0.5098039216, blue: 0.5215686275, alpha: 1) //128, 130, 133
    }()
    static let textBlack: UIColor = {
        return #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1) //30, 30, 30
    }()
    static let blueColor: UIColor = {
        return #colorLiteral(red: 0, green: 0.4980392157, blue: 1, alpha: 1) //0, 127, 255
    }()
    static let borderColor: UIColor = {
        return #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1) //112, 112, 112
    }()
    static let textGray2: UIColor = {
        return #colorLiteral(red: 0.3450980392, green: 0.3490196078, blue: 0.3568627451, alpha: 1) //88, 89, 91
    }()
    static let textColor: UIColor = {
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1) //51, 51, 51
    }()
    static let textLightGray: UIColor = {
        return #colorLiteral(red: 0.7294117647, green: 0.737254902, blue: 0.7450980392, alpha: 1) //186, 188, 190
    }()
    static let darkRed: UIColor = {
        return #colorLiteral(red: 0.7294117647, green: 0.1254901961, blue: 0.1529411765, alpha: 1) //186, 32, 39
    }()
    static let statusPaid: UIColor = {
        return #colorLiteral(red: 0.4431372549, green: 0.7529411765, blue: 0.08235294118, alpha: 1) //113, 192, 21
    }()
    static let statusReject: UIColor = {
        return #colorLiteral(red: 1, green: 0.6362844706, blue: 0, alpha: 1) //255, 152, 0
    }()
    static let statusPending: UIColor = {
        return #colorLiteral(red: 1, green: 0.3161430061, blue: 0.3161430061, alpha: 1)
    }()
    static let lineChart: UIColor = {
        return #colorLiteral(red: 0.9112530947, green: 0.2946455479, blue: 0.1772339046, alpha: 1)
    }()
    static let thatBaicolo: UIColor = {
        return #colorLiteral(red: 1, green: 0.2784313725, blue: 0.2784313725, alpha: 1)
    }()
    static let gray6 : UIColor = {
        return #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1)
    }()
    static let grey : UIColor = {
        return #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
    }()
}
