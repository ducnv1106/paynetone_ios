//
//  ForgotPasswordInputNewPassVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 14/09/2022.
//

import UIKit
import SwiftTheme

class ForgotPasswordInputNewPassVC: BaseUI {
    private var lbNewPass :UILabel!
    private var tfNewPass:UITextField!
    private var lbNewPassConfirm :UILabel!
    private var tfNewPassConfirm :UITextField!
    private var lbNote :UILabel!
    private var btnConfirm = POMaker.makeButton(title: "Xác nhận")
    var mobileNumber = ""
    var otp = ""
    private var isShowHidePassword: Bool = true
    private var isShowConfirmPassword: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quên mật khẩu"
        initUI()
        setupView()
        //        configThemeView()
    }
    
    private func initUI(){
        lbNewPass = POMaker.makeLabel(text: "Mật khẩu mới *", require: true)
        tfNewPass = POMaker.makeTextField(placeholder: "Nhập mật khẩu mới",textColor: .black ,isPass: true)
        lbNewPassConfirm = POMaker.makeLabel(text: "Xác nhận mật khẩu *", require: true)
        tfNewPassConfirm = POMaker.makeTextField(placeholder: "Nhập lại mật khẩu mới",textColor: .black ,isPass: true)
        lbNote = POMaker.makeLabel(text: "Lưu ý: Độ dài mật khẩu yêu cầu từ 6-50 ký tự, bao gồm ít nhất một ký tự viết thường, một ký tự chữ số, một ký tự đặc biệt và một ký tự viết hoa.", color: .red, alignment: .center)
        btnConfirm = POMaker.makeButton(title: "Xác nhận")
    }
    private func setupView(){
        view.addSubviews(views: lbNewPass, tfNewPass, lbNewPassConfirm, tfNewPassConfirm, lbNote, btnConfirm)
        lbNewPass.safeTop(toView: view, space: 20)
        lbNewPass.left(toView: view, space: 14)
        
        tfNewPass.top(toAnchor: lbNewPass.bottomAnchor, space: 6)
        tfNewPass.horizontal(toView: view, space: 14)
        tfNewPass.height(50)
        tfNewPass.isSecureTextEntry = true
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let btnShowHide = UIButton()
        btnShowHide.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnShowHide.imageView?.tintColor = .gray
        btnShowHide.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        btnShowHide.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
        emptyView.addSubview(btnShowHide)
        emptyView.contentMode = .left
        tfNewPass.rightView = emptyView
        tfNewPass.rightViewMode = .always
        
        lbNewPassConfirm.top(toAnchor: tfNewPass.bottomAnchor, space: 14)
        lbNewPassConfirm.left(toView: view, space: 14)
        
        tfNewPassConfirm.top(toAnchor: lbNewPassConfirm.bottomAnchor, space: 6)
        tfNewPassConfirm.horizontal(toView: view, space: 14)
        tfNewPassConfirm.height(50)
        tfNewPassConfirm.isSecureTextEntry = true
        let emptyViewC = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let btnShowHideC = UIButton()
        btnShowHideC.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnShowHideC.imageView?.tintColor = .gray
        btnShowHideC.addTarget(self, action: #selector(showHideConfirmPassword), for: .touchUpInside)
        btnShowHideC.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
        emptyViewC.addSubview(btnShowHideC)
        emptyViewC.contentMode = .left
        tfNewPassConfirm.rightView = emptyViewC
        tfNewPassConfirm.rightViewMode = .always
        
        lbNote.top(toAnchor: tfNewPassConfirm.bottomAnchor, space: 20)
        lbNote.horizontal(toView: view, space: 14)
        
        btnConfirm.safeBottom(toView: view, space: 10)
        btnConfirm.horizontal(toView: view, space: 14)
        btnConfirm.height(50)
        btnConfirm.addTarget(self, action: #selector(btnConfirm_touchUp), for: .touchUpInside)
    }
    
    @objc func showHidePassword(_ sender: UIButton){
        if(isShowHidePassword == true) {
            tfNewPass.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            tfNewPass.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        isShowHidePassword = !isShowHidePassword
    }
    @objc func showHideConfirmPassword(_ sender: UIButton){
        if(isShowConfirmPassword == true) {
            tfNewPassConfirm.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            tfNewPassConfirm.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        isShowConfirmPassword = !isShowConfirmPassword
    }
    @objc private func btnConfirm_touchUp(){
        if (tfNewPass.text ?? "").isEmpty {
            self.showToast(message: "Bạn chưa nhập mật khẩu", delay: 2)
            return
        }
        if (tfNewPassConfirm.text ?? "").isEmpty{
            self.showToast(message: "Bạn chưa nhập lại mật khẩu", delay: 2)
            return
        }
        if tfNewPass.text != tfNewPassConfirm.text {
            self.showToast(message: "Xác nhận mật khẩu không khớp, vui lòng thử lại", delay: 2)
            return
        }
        if let pass = tfNewPass.text, !pass.checkPass {
            self.showToast(message: "Mật khẩu phải từ 6-50 ký tự, có ít nhất 1 ký tự hoa, 1 ký tự thường, 1 ký tự đặc biệt, 1 ký tự số", delay: 2)
            return
        }
        let rq = ChangePassRequest()
        rq.mobileNumber = mobileNumber
        rq.OTPValue = otp
        rq.passwordNew = tfNewPass.text
        self.showLoading()
        let rqString = Utils.objToString(rq)
        ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_UPDATE_PASSWORD_BY_OTP") { code, message in
            self.hideLoading()
            if code == "00" {
                self.navigationController?.pushViewController(ForgotPasswordChangeSuccessVC(), animated: true)
            } else {
                self.showToast(message: message ?? "", delay: 2)
            }
        }
    }
}
