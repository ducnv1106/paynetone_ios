//
//  UIFont.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 06/08/2022.
//

import UIKit

extension UIFont {
    static var helvetica: UIFont = {
        return UIFont.init(name: "Helvetica", size: 14)!
    }()
    
    func setBold() -> UIFont
    {
        var fontAtrAry = fontDescriptor.symbolicTraits
        fontAtrAry.insert([.traitBold])
        let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
        return UIFont(descriptor: fontAtrDetails!, size: pointSize)
    }
    
    func setItalic() -> UIFont
    {
        var fontAtrAry = fontDescriptor.symbolicTraits
        fontAtrAry.insert([.traitItalic])
        let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
        return UIFont(descriptor: fontAtrDetails!, size: pointSize)
    }
    
    func desetBold() -> UIFont
    {
        var fontAtrAry = fontDescriptor.symbolicTraits
        fontAtrAry.remove([.traitBold])
        let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
        return UIFont(descriptor: fontAtrDetails!, size: pointSize)
    }
    
    func desetItalic()-> UIFont
    {
        var fontAtrAry = fontDescriptor.symbolicTraits
        fontAtrAry.remove([.traitItalic])
        let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
        return UIFont(descriptor: fontAtrDetails!, size: pointSize)
    }
}
