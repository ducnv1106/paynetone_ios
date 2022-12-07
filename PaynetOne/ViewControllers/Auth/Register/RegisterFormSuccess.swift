////
////  RegisterForm3.swift
////  PaynetOne
////
////  Created by vinatti on 10/02/2022.
////

import UIKit
import SwiftTheme

class RegisterFormSuccess: UIViewController {
    private let lbTitle = POMaker.makeLabel(text: "Hoàn tất đăng ký", font: .helvetica.withSize(20).setBold(), alignment: .center)
    private let lbMessage = POMaker.makeLabel(text: "Chúc mừng bạn đã đăng ký tài khoản Merchant Paynet One thành công.", font: .helvetica.withSize(16), alignment: .center)
    private let buttonSucess = POMaker.makeButton(title: "Hoàn tất")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.theme_backgroundColor = ThemeColorPicker(colors: "#000", "#F2F2F3")
        navigationItem.hidesBackButton = true
        title = "ĐĂNG KÝ TÀI KHOẢN"
        view.addSubviews(views: lbTitle, lbMessage, buttonSucess)
        lbTitle.safeTop(toView: view, space: 40)
        lbTitle.horizontal(toView: view)
        
        lbMessage.top(toAnchor: lbTitle.bottomAnchor, space: 16)
        lbMessage.horizontal(toView: view, space: 16)
        
        buttonSucess.safeBottom(toView: view, space: 10)
        buttonSucess.horizontal(toView: view, space: 16)
        buttonSucess.height(50)
        buttonSucess.addTarget(self, action: #selector(buttonSucess_touchUp), for: .touchUpInside)
//        configThemeView()
    }
    
    @objc private func buttonSucess_touchUp(){
        popToViewController(navigationController: navigationController!, className: LoginViewController.self)
    }
    
    private func configThemeView(){
        lbTitle.theme_textColor = ThemeColorPicker(colors: "#FFF")
        lbMessage.theme_textColor = ThemeColorPicker(colors: "#FFF")
        
    }
}
