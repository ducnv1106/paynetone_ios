//
//  UIButton.swift
//  PaynetOne
//
//  Created by vinatti on 29/12/2021.
//

import Foundation
import UIKit
extension UIButton {
    @available(iOS 15.0, *)
    func centerVertically() -> UIButton.Configuration{
        var filled = UIButton.Configuration.filled()
        filled.imagePlacement = .top
        filled.baseBackgroundColor = UIColor.white.withAlphaComponent(0)
        filled.imagePadding = 30
        return filled
    }
    
    func alignVertical(spacing: CGFloat, lang: String) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
        else { return }

        let labelString = NSString(string: text)
        let titleSize = labelString.size(
            withAttributes: [NSAttributedString.Key.font: font]
        )

        var titleLeftInset: CGFloat = -imageSize.width
        var titleRigtInset: CGFloat = 0.0

        var imageLeftInset: CGFloat = 0.0
        var imageRightInset: CGFloat = -titleSize.width

        if Locale.current.languageCode! != "en" { // If not Left to Right language
            titleLeftInset = 0.0
            titleRigtInset = -imageSize.width

            imageLeftInset = -titleSize.width
            imageRightInset = 0.0
        }

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: titleLeftInset,
            bottom: -(imageSize.height + spacing),
            right: titleRigtInset
        )
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(titleSize.height + spacing),
            left: imageLeftInset,
            bottom: 0.0,
            right: imageRightInset
        )
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(
            top: edgeOffset,
            left: 0.0,
            bottom: edgeOffset,
            right: 0.0
        )
    }
    
    func buildPrimaryButton(){
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundColor = Colors.primaryColor
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    func buttonConstraint(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, centerXOffset: CGFloat = 0, centerYOffset: CGFloat = 0){
        self.translatesAutoresizingMaskIntoConstraints = false
        var anchored = AnchorConstrain()
        if let top = top {
            anchored.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }

        if let left = left {
            anchored.left = leftAnchor.constraint(equalTo: left, constant: padding.left)
        }

        if let bottom = bottom {
            anchored.bottom = bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom)
        }

        if let right = right {
            anchored.right = rightAnchor.constraint(equalTo: right, constant: padding.right)
        }

        if size.width != 0 {
            anchored.width = widthAnchor.constraint(equalToConstant: size.width)
        }

        if size.height != 0 {
            anchored.height = heightAnchor.constraint(equalToConstant: size.height)
        }

        if let centerX = centerX {
            anchored.centerX = centerXAnchor.constraint(equalTo: centerX, constant: centerXOffset)
        }

        if let centerY = centerY {
            anchored.centerY = centerYAnchor.constraint(equalTo: centerY, constant: centerYOffset)
        }
        [anchored.top, anchored.left, anchored.bottom, anchored.right, anchored.width, anchored.height, anchored.centerX, anchored.centerY].forEach { $0?.isActive = true }
    }
}
