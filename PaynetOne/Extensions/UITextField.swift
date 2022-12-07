//
//  UITextField.swift
//  PaynetOne
//
//  Created by vinatti on 30/12/2021.
//

import Foundation
import UIKit

extension UITextField {
    
    ///set line bottom cho text field
    func setBottomLine(_ width: CGFloat? = nil){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: -5, y: 40, width: width ?? UIScreen.main.bounds.width - 30, height: 0.5)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupPrimaryTextField(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        layer.borderWidth = 0.5
        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.borderColor = UIColor.gray.cgColor
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        leftView = paddingView
        leftViewMode = .always
    }
    
    func formatCurrency(string: String) {
        print("format \(string)")
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
        let numberFromField = (NSString(string: string).doubleValue)/100
        //replace billTextField with your text field name
        self.text = formatter.string(from: NSNumber(value: numberFromField))
        print(self.text ?? "" )
    }
    
    ///constraint textfield
    func tfConstraint(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, centerXOffset: CGFloat = 0, centerYOffset: CGFloat = 0){
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
    
    func addDoneButtonOnKeyBoardWithControl() {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        keyboardToolbar.sizeToFit()
        keyboardToolbar.barStyle = .default
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(image: UIImage(named: "keyboard_hidden"), style: .done, target: self, action: #selector(endEditing(_:)))
        doneBarButton.tintColor = .black
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputAccessoryView = keyboardToolbar
    }
    @objc func showHidePassword(_ sender: UIButton){
        if isSecureTextEntry {
            sender.setImage(UIImage(named: "eye_hidding")?.resized(to: CGSize(width: 24, height: 24)).withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            sender.setImage(UIImage(named: "eye_showing")?.resized(to: CGSize(width: 24, height: 24)).withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
    
    func maxLength(range: NSRange, string: String, max: Int) -> Bool {
        let currentCharacterCount = self.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= max
    }
}
