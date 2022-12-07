//
//  UILabel.swift
//  PaynetOne
//
//  Created by vinatti on 10/01/2022.
//

import UIKit

extension UILabel {
    func labelConstraints(top: NSLayoutYAxisAnchor? = nil, marginTop: CGFloat = 0.0, left: NSLayoutXAxisAnchor? = nil, marginLeft: CGFloat = 0.0, bottom: NSLayoutYAxisAnchor? = nil, marginBottom: CGFloat = 0.0, right: NSLayoutXAxisAnchor? = nil, marginRight: CGFloat = 0.0, centerX: NSLayoutXAxisAnchor? = nil, centerXOffset: CGFloat = 0, centerY: NSLayoutYAxisAnchor? = nil, centerYOffset: CGFloat = 0){
        var anchored = AnchorConstrain()
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            anchored.top = topAnchor.constraint(equalTo: top, constant: marginTop)
        }
        if let left = left {
            anchored.left = leftAnchor.constraint(equalTo: left, constant: marginLeft)
        }
        if let bottom = bottom {
            anchored.bottom = bottomAnchor.constraint(equalTo: bottom, constant: marginBottom)
        }
        if let right = right {
            anchored.right = rightAnchor.constraint(equalTo: right, constant: marginRight)
        }
        if let centerX = centerX {
            anchored.centerX = centerXAnchor.constraint(equalTo: centerX, constant: centerXOffset)
        }
        if let centerY = centerY {
            anchored.centerY = centerYAnchor.constraint(equalTo: centerY, constant: centerYOffset)
        }
        [anchored.top, anchored.left, anchored.bottom, anchored.right, anchored.centerX, anchored.centerY].forEach { $0?.isActive = true }
    }
    
    func addRangeGesture(_ stringRange: String, _ location: Int, _ length: Int) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        let range = NSRange(location: location, length: length)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.primaryColor, range: range)
        self.attributedText = attributedString
        UITapGestureRecognizer.stringRange = stringRange
//        UITapGestureRecognizer.function = function
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_:)))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
    }
    
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer){
        guard let text = self.text else { return }
        let stringRange = (text as NSString).range(of: UITapGestureRecognizer.stringRange ?? "")
        if gesture.didTapAttributedTextInLabel(label: self, inRange: stringRange) {
            guard let existedFunction = UITapGestureRecognizer.function else { return }
            existedFunction()
        }
    }
}
