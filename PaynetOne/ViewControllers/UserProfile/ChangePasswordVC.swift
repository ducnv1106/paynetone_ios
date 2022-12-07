//
//  ChangePasswordVC.swift
//  PaynetOne
//
//  Created by Duoc Nguyen  on 09/11/2022.
//

import UIKit

class ChangePasswordVC: BaseUI {
    
    private var glH4 = POMaker.makeView(backgroundColor: .clear)
    
    private var lbOldPassword = POMaker.makeLabel(text: "Mật khẩu cũ", font: .helvetica.withSize(15),color: .black)
    private var tfOldPassword = POMaker.makeTextField(text: nil, placeholder: "Mật khẩu cũ", font: .helvetica.withSize(14), textColor: .black, textAlignment: .left, backgroundColor: .clear, borderWidth: 0, borderColor: .clear, cornerRadius: 0)
    
    
    private var lbNewPassword = POMaker.makeLabel(text: "Mật khẩu mới", font: .helvetica.withSize(15),color: .black)
    private var tfNewPassword = POMaker.makeTextField(text: nil, placeholder: "Mật khẩu mới", font: .helvetica.withSize(14), textColor: .black, textAlignment: .left, backgroundColor: .clear, borderWidth: 0, borderColor: .clear, cornerRadius: 0)
    
    private var lbConfirmPassword = POMaker.makeLabel(text: "Xác nhận mật khẩu mới", font: .helvetica.withSize(15),color: .black)
    private var tfConfirmPassword = POMaker.makeTextField(text: nil, placeholder: "Xác nhận mật khẩu mới", font: .helvetica.withSize(14), textColor: .black, textAlignment: .left, backgroundColor: .clear, borderWidth: 0, borderColor: .clear, cornerRadius: 0)
    
    private var btnUpdate = POMaker.makeButton(title: "CẬP NHẬT", font: .helvetica.withSize(14), color: .white,backgroundColor: .blueColor)
    
    private var viewLine1 = POMaker.makeView(backgroundColor: .textLightGray)
    private var viewLine2 = POMaker.makeView(backgroundColor: .textLightGray)
    
    private var isShowHidePassword: Bool = true
    private var isShowHideNewPassword: Bool = true
    private var isShowHideConfirmPassword: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ĐỔI MẬT KHẨU"
        initUI()
        configUI()
        
    }
    
    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.view.subviews.map({ $0.removeFromSuperview() })
            self.initUI()
            self.configUI()
            self.configThemeView()
            self.view.layoutIfNeeded()
        }
        
    }
    
    private func initUI(){
        glH4 = POMaker.makeView(backgroundColor: .clear)
        
        lbOldPassword = POMaker.makeLabel(text: "Mật khẩu cũ", font: .helvetica.withSize(15),color: .black)
        tfOldPassword = POMaker.makeTextField(text: nil, placeholder: "Mật khẩu cũ", font: .helvetica.withSize(14), textColor: .black, textAlignment: .left, backgroundColor: .clear, borderWidth: 0, borderColor: .clear, cornerRadius: 0)
        
        
        lbNewPassword = POMaker.makeLabel(text: "Mật khẩu mới", font: .helvetica.withSize(15),color: .black)
        tfNewPassword = POMaker.makeTextField(text: nil, placeholder: "Mật khẩu mới", font: .helvetica.withSize(14), textColor: .black, textAlignment: .left, backgroundColor: .clear, borderWidth: 0, borderColor: .clear, cornerRadius: 0)
        
        lbConfirmPassword = POMaker.makeLabel(text: "Xác nhận mật khẩu mới", font: .helvetica.withSize(15),color: .black)
        tfConfirmPassword = POMaker.makeTextField(text: nil, placeholder: "Xác nhận mật khẩu mới", font: .helvetica.withSize(14), textColor: .black, textAlignment: .left, backgroundColor: .clear, borderWidth: 0, borderColor: .clear, cornerRadius: 0)
        
        btnUpdate = POMaker.makeButton(title: "CẬP NHẬT", font: .helvetica.withSize(14), color: .white,backgroundColor: .blueColor)
        
        viewLine1 = POMaker.makeView(backgroundColor: .textLightGray)
        viewLine2 = POMaker.makeView(backgroundColor: .textLightGray)
    }
    
    private func configUI(){
        view.addSubview(glH4)
        glH4.viewConstraints(top: view.safeTopAnchor, left: nil, bottom: view.bottomAnchor,size: CGSize(width: 0.3, height: 0))
        
        let xConstraintGL4 = NSLayoutConstraint(item: glH4,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: self.view,
                                                attribute: .left,
                                                multiplier: 1,
                                                constant: (Display.width) * 0.35);
        NSLayoutConstraint.activate([xConstraintGL4])
        
        // view old password
        view.addSubview(lbOldPassword)
        lbOldPassword.viewConstraints(top: view.safeTopAnchor, left: view.leftAnchor, bottom: nil, right: glH4.leftAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        lbOldPassword.height(35)
        
        
        view.addSubview(tfOldPassword)
        tfOldPassword.viewConstraints(top: lbOldPassword.topAnchor, left: glH4.rightAnchor, bottom: lbOldPassword.bottomAnchor, right: view.rightAnchor,padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let btnShowHide = UIButton()
        btnShowHide.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnShowHide.imageView?.tintColor = .gray
        btnShowHide.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        btnShowHide.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
        emptyView.addSubview(btnShowHide)
        emptyView.contentMode = .left
        tfOldPassword.rightView = emptyView
        tfOldPassword.rightViewMode = .always
        tfOldPassword.isSecureTextEntry = true
        
        view.addSubview(viewLine1)
        viewLine1.viewConstraints(top: lbOldPassword.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        viewLine1.height(0.7)
        
        // view new password
        view.addSubview(lbNewPassword)
        lbNewPassword.viewConstraints(top: viewLine1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: glH4.leftAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        lbNewPassword.height(35)
        
        view.addSubview(tfNewPassword)
        tfNewPassword.viewConstraints(top: lbNewPassword.topAnchor, left: glH4.rightAnchor, bottom: lbNewPassword.bottomAnchor, right: view.rightAnchor,padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        
        let emptyView2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let btnShowHide2 = UIButton()
        btnShowHide2.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnShowHide2.imageView?.tintColor = .gray
        btnShowHide2.addTarget(self, action: #selector(showHideNewPassword), for: .touchUpInside)
        btnShowHide2.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
        emptyView2.addSubview(btnShowHide2)
        emptyView2.contentMode = .left
        tfNewPassword.rightView = emptyView2
        tfNewPassword.rightViewMode = .always
        tfNewPassword.isSecureTextEntry = true
        
        view.addSubview(viewLine2)
        viewLine2.viewConstraints(top: lbNewPassword.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor)
        viewLine2.height(0.5)
        
        // view confirm password
        view.addSubview(lbConfirmPassword)
        lbConfirmPassword.viewConstraints(top: viewLine2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: glH4.leftAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        lbConfirmPassword.height(35)
        
        view.addSubview(tfConfirmPassword)
        tfConfirmPassword.viewConstraints(top: lbConfirmPassword.topAnchor, left: glH4.rightAnchor, bottom: lbConfirmPassword.bottomAnchor, right: view.rightAnchor,padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        
        let emptyView3 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let btnShowHide3 = UIButton()
        btnShowHide3.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnShowHide3.imageView?.tintColor = .gray
        btnShowHide3.addTarget(self, action: #selector(showHideConfirmPassword), for: .touchUpInside)
        btnShowHide3.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
        emptyView3.addSubview(btnShowHide3)
        emptyView3.contentMode = .left
        tfConfirmPassword.rightView = emptyView3
        tfConfirmPassword.rightViewMode = .always
        tfConfirmPassword.isSecureTextEntry = true
        
        view.addSubview(btnUpdate)
        btnUpdate.viewConstraints(top: lbConfirmPassword.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10))
        btnUpdate.height(35)
        btnUpdate.addTarget(self, action: #selector(requestChangePassword), for: .touchUpInside)
    }
    
    private func configThemeView(){
        if isDarkMode{
            view.backgroundColor = .black
        }else{
            view.backgroundColor = .white
        }
    }
    
    
    
    @objc private func requestChangePassword(){
        if confirmInput(){
            let userString = StoringService.shared.getData(Constants.userData)
            let userData = UserModel(JSONString: userString)
            
            let mobileNumber = userData?.phoneNumber ?? ""
            let oldPassword = tfOldPassword.text ?? ""
            let newPassword = tfNewPassword.text ?? ""
            
            
            let rq = ChangePasswordRq(mobileNumber: mobileNumber, password: oldPassword, passwordNew: newPassword)
            let rqString = Utils.objToString(rq)
            self.showLoading()
            
            ApiManager.shared.requestCodeMessage(dataRq: rqString, code: "EMP_UPDATE_PASSWORD") { code, message in
                self.hideLoading()
                if code == "00" {
                    let modal = SuccessModalView()
                    modal.message = "Thay đổi mật khẩu thành công!"
                    self.popupWithView(vc: modal, okBtnTitle: "Đóng", okAction: {
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    self.showToast(message: message ?? "", delay: 2, position: .center)
                }
            }
        }
        
        
    }
    
    @objc func showHidePassword(_ sender: UIButton){
        if(isShowHidePassword == true) {
            tfOldPassword.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            tfOldPassword.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        isShowHidePassword = !isShowHidePassword
    }
    
    @objc func showHideNewPassword(_ sender: UIButton){
        if(isShowHideNewPassword == true) {
            tfNewPassword.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            tfNewPassword.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        isShowHideNewPassword = !isShowHideNewPassword
    }
    
    @objc func showHideConfirmPassword(_ sender: UIButton){
        if(isShowHideConfirmPassword == true) {
            tfConfirmPassword.isSecureTextEntry = false
            sender.setImage(UIImage(named: "eye_hidding")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        } else {
            tfConfirmPassword.isSecureTextEntry = true
            sender.setImage(UIImage(named: "eye_showing")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.imageView?.tintColor = .gray
        }
        isShowHideConfirmPassword = !isShowHideConfirmPassword
    }
    
    private func validateOldPassword() -> Bool{
        guard let password = tfOldPassword.text?.trimmingCharacters(in: .whitespaces) else {return false}
        if password.isEmpty {
            self.showToast(message: "Xin vui lòng nhập mật khẩu cũ!", delay: 2,position: .center)
            return false
        }
        return true
    }
    private func validateNewPassword() -> Bool{
        guard let password = tfNewPassword.text?.trimmingCharacters(in: .whitespaces) else {return false}
        if password.isEmpty {
            self.showToast(message: "Xin vui lòng nhập mật khẩu mới!", delay: 2,position: .center)
            return false
        }
        return true
    }
    private func validateConfirmPassword() -> Bool{
        guard let password = tfConfirmPassword.text?.trimmingCharacters(in: .whitespaces) else {return false}
        if password.isEmpty {
            self.showToast(message: "Xin vui lòng xác nhận mật khẩu mới!", delay: 2,position: .center)
            return false
        }
        if password.count < 6 || password.count > 50 {
            self.showToast(message: "Mật khẩu có độ dài tối thiểu 6 ký tự và tối đa 50 ký tự!", delay: 2,position: .center)
            return false
        }
        if !password.checkPass{
            self.showToast(message: "Mật khẩu gồm ít nhất một ký tự viết thường, một ký tự chữ số,một ký tự đặc biệt và một ký tự hoa", delay: 2,position: .center)
            return false
        }
        return true
    }
    private func validateNotMatchPassword()->Bool{
        guard let password = tfNewPassword.text?.trimmingCharacters(in: .whitespaces) else {return false}
        guard let confirmPassword = tfConfirmPassword.text?.trimmingCharacters(in: .whitespaces) else {return false}
        if password != confirmPassword{
            self.showToast(message: "Mật khẩu mới và xác nhận không trùng nhau", delay: 2,position: .center)
            return false
        }
        return true
    }
    
    private func validateOldEqualsNewPassword()->Bool{
        guard let password = tfOldPassword.text?.trimmingCharacters(in: .whitespaces) else {return false}
        guard let newPassword = tfNewPassword.text?.trimmingCharacters(in: .whitespaces) else {return false}
        if password == newPassword{
            self.showToast(message: "Mật khẩu mới không được trùng với mật khẩu cũ!", delay: 2, position: .center)
            return false
        }
        return true
    }
    
    private func confirmInput() -> Bool{
        if (!validateOldPassword() || !validateNewPassword() || !validateConfirmPassword() || !validateNotMatchPassword() || !validateNotMatchPassword()){
            return false
        }
        return true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ChangePasswordVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 0
        if textField == tfNewPassword {
            maxLength = 50
        }
        
        if textField == tfConfirmPassword {
            maxLength = 50
        }
        
        return textField.maxLength(range: range, string: string, max: maxLength)
    }
}
