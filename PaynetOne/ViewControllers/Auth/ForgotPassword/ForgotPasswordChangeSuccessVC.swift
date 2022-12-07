//
//  ForgotPasswordChangeSuccessVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 14/09/2022.
//

import UIKit
import SwiftTheme

class ForgotPasswordChangeSuccessVC: BaseUI {
    private var lbNoti : UILabel!
    private var lbCongrass : UILabel!
    private var btnHoanTat :UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quên mật khẩu"
        initUI()
        let leftBarButton = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: nil)
        leftBarButton.customView?.viewConstraints(size: CGSize(width: 0, height: 0))
        navigationItem.leftBarButtonItem = leftBarButton
        
        view.addSubviews(views: lbNoti, lbCongrass, btnHoanTat)
        lbNoti.safeTop(toView: view, space: 40)
        lbNoti.centerX(toView: view)
        
        lbCongrass.top(toAnchor: lbNoti.bottomAnchor, space: 14)
        lbCongrass.horizontal(toView: view, space: 30)
        
        btnHoanTat.top(toAnchor: lbCongrass.bottomAnchor, space: 30)
        btnHoanTat.horizontal(toView: view, space: 24)
        btnHoanTat.height(50)
        btnHoanTat.addTarget(self, action: #selector(btnHoanTat_touchUp), for: .touchUpInside)
        
    }
    
    private func initUI(){
        lbNoti = POMaker.makeLabel(text: "Hoàn tất đổi mật khẩu", font: .helvetica.withSize(20))
        lbCongrass = POMaker.makeLabel(text: "Chúc mừng bạn đã đổi mật khẩu tài khoản Merchant Paynet One thành công", font: .helvetica.withSize(18), alignment: .center)
        btnHoanTat = POMaker.makeButton(title: "Hoàn tất")
    }
    
    @objc private func btnHoanTat_touchUp(){
        popToViewController(navigationController: navigationController!, className: LoginViewController.self)
    }
}
