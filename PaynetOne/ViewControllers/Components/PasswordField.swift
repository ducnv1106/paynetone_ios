//
//  PasswordField.swift
//  PaynetOne
//
//  Created by vinatti on 10/02/2022.
//

import UIKit

class PasswordField: UITextField {
    let btnShowHide = UIButton()
    var isShowHidePassword: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSecureTextEntry = true
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 50))
        btnShowHide.frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        emptyView.addSubview(btnShowHide)
        let placeholder = NSAttributedString(string: "Mật khẩu", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)])
        self.attributedPlaceholder = placeholder
        btnShowHide.addTarget(self, action: #selector(showHidePass), for: .touchUpInside)
        btnShowHide.setImage(UIImage(named: "eye_showing"), for: .normal)
        emptyView.contentMode = .left
        self.setBottomLine()
        self.rightView = emptyView
        self.rightViewMode = .always
        self.textColor = .black
    }
    
    @objc func showHidePass(_ sender: UIButton){
        if(isShowHidePassword == true) {
            self.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding"), for: .normal)
        } else {
            self.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing"), for: .normal)
        }
        isShowHidePassword = !isShowHidePassword
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
