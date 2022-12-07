//
//  UITextView.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 31/08/2022.
//

import UIKit

extension UITextView {
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
}
