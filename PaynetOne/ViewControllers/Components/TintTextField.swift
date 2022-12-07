//
//  TintTextField.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 04/04/2022.
//

import Foundation
import UIKit

class TintTextField: UITextField {
    var tintedClearImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTintColor()
    }
    
    func setupTintColor(){
        let placeholder = NSAttributedString(string: "Placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)])
        self.attributedPlaceholder = placeholder
        self.textColor = .black
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tintClearImage()
    }
    
    private func tintClearImage(){
        for view in subviews {
            if view is UIButton {
                let button = view as! UIButton
                if let image = button.image(for: .highlighted) {
                    if self.tintedClearImage == nil {
                        tintedClearImage = self.tintImage(image: image, color: .black)
                    }
                    button.setImage(self.tintedClearImage, for: .normal)
                    button.setImage(self.tintedClearImage, for: .highlighted)
                }
            }
        }
    }
    
    private func tintImage(image: UIImage, color: UIColor) -> UIImage {
        let size = image.size

        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        image.draw(at: .zero, blendMode: CGBlendMode.normal, alpha: 1.0)

        context?.setFillColor(color.cgColor)
        context?.setBlendMode(CGBlendMode.sourceIn)
        context?.setAlpha(1.0)

        let rect = CGRect(x: CGPoint.zero.x, y: CGPoint.zero.y, width: image.size.width, height: image.size.height)
        UIGraphicsGetCurrentContext()?.fill(rect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage ?? UIImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
