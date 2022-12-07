//
//  LoginView.swift
//  PaynetOne
//
//  Created by vinatti on 27/12/2021.
//

import UIKit

class LoginView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        self.hideKeyboardWhenTappedOutside()
        txtPhoneNumber.addBorder()
        txtPhoneNumber.keyboardType = .phonePad
        
        txtPassword.addBorder()
        txtPassword.isSecureTextEntry = true
        btnLogin.layer.cornerRadius = 10
    }
    
    func setDelegates(){
        txtPassword.delegate = self
        txtPhoneNumber.delegate = self
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
    }
}
extension UITextField {
    func addBorder(){
//        let border = CALayer()
//        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1)
//        border.backgroundColor = UIColor.red.cgColor
//        borderStyle = .none
//        layer.addSublayer(border)
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
}
