//
//  ForgotPasswordGetOTPVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 17/05/2022.
//

import UIKit
import SwiftTheme

class ForgotPasswordGetOTPVC: BaseUI {
    private var lbTitle1 : UILabel!
    private var lbTitle2 : UILabel!
    private var lbMobileNumber : UILabel!
    private var tfMobileNumber : UITextField!
    private var btnContinue :UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quên mật khẩu"
        //        configThemeView()
        initUI()
        setupView()
    }
    private func setupView(){
        view.addSubviews(views: lbTitle1, lbTitle2, lbMobileNumber, tfMobileNumber, btnContinue)
        lbTitle1.safeTop(toView: view, space: 20)
        lbTitle1.horizontal(toView: view, space: 20)
        
        lbTitle2.top(toAnchor: lbTitle1.bottomAnchor)
        lbTitle2.horizontal(toView: view, space: 25)
        
        lbMobileNumber.top(toAnchor: lbTitle2.bottomAnchor, space: 30)
        lbMobileNumber.left(toView: view, space: 14)
        
        tfMobileNumber.top(toAnchor: lbMobileNumber.bottomAnchor, space: 6)
        tfMobileNumber.horizontal(toView: view, space: 14)
        tfMobileNumber.height(50)
        tfMobileNumber.keyboardType = .phonePad
        tfMobileNumber.delegate = self
        
        btnContinue.safeBottom(toView: view, space: 10)
        btnContinue.horizontal(toView: view, space: 14)
        btnContinue.height(50)
        btnContinue.addTarget(self, action: #selector(continue_touchUp), for: .touchUpInside)
    }
    
    private func initUI(){
        lbTitle1 = POMaker.makeLabel(text: "Vui lòng nhập chính xác số điện thoại đã đăng ký tài khoản kinh doanh.", font: .helvetica.withSize(16), alignment: .center)
        lbTitle2 = POMaker.makeLabel(text: "Mã xác thực sẽ được gửi để xác minh tài khoản", font: .helvetica.withSize(16).setBold(), alignment: .center)
        lbMobileNumber = POMaker.makeLabel(text: "Số điện thoại *", font: .helvetica.withSize(16), require: true)
        tfMobileNumber = POMaker.makeTextField(placeholder: "Nhập số điện thoại", font: .helvetica.withSize(16))
        btnContinue = POMaker.makeButton(title: "Tiếp tục")
    }
    @objc private func continue_touchUp(){
        guard let phoneNum = tfMobileNumber.text?.trimmingCharacters(in: .whitespaces) else {return}
        if phoneNum.isEmpty {
            self.showToast(message: "Bạn chưa nhập số điện thoại", delay: 2)
        } else if !phoneNum.phoneValidate() {
            self.showToast(message: "Số điện thoại không hợp lệ", delay: 2)
        } else {
            self.showLoading()
            let rq = RequestOtp()
            rq.mobileNumber = phoneNum
            rq.isForget = "Y"
            let rqString = Utils.objToString(rq)
            ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_GET_OTP") { code, message in
                self.hideLoading()
                if code == "00" {
                    let vc = ForgotPasswordInputOtpVC()
                    vc.mobileNumber = phoneNum
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.showToast(message: message ?? "", delay: 2)
                }
            }
        }
    }
}
extension ForgotPasswordGetOTPVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.maxLength(range: range, string: string, max: 10)
    }
}
